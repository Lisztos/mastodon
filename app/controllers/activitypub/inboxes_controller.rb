# frozen_string_literal: true

class ActivityPub::InboxesController < ActivityPub::BaseController
  include DidcommHelper
  include SignatureVerification
  include JsonLdHelper
  include AccountOwnedConcern

  before_action :skip_unknown_actor_activity
  before_action :require_signature!, unless: :encrypted?
  skip_before_action :authenticate_user!

  def create
    upgrade_account
    process_collection_synchronization
    process_payload
    head 202
  end

  private

  def encrypted?
    Rails.logger.info "raw post: #{request.raw_post}"
    body = Oj.load(request.raw_post, mode: :strict).with_indifferent_access
    
    @raw_data = Oj.dump(body[:payload])
    body[:payload].start_with?(JWT_SUFFIX)
  end

  def skip_unknown_actor_activity
    head 202 if unknown_affected_account?
  end

  def unknown_affected_account?
    json = Oj.load(body, mode: :strict)
    json.is_a?(Hash) && %w(Delete Update).include?(json['type']) && json['actor'].present? && json['actor'] == value_or_id(json['object']) && !Account.where(uri: json['actor']).exists?
  rescue Oj::ParseError
    false
  end

  def account_required?
    params[:account_username].present?
  end

  def skip_temporary_suspension_response?
    true
  end

  def body
    return @body if defined?(@body)

    if @verified_data.present?
      @body = @verified_data
      Rails.logger.info "@Body #{@body.class} is now: #{@body}"
    else
      @body = @raw_data
    end
    # @body.force_encoding('UTF-8') if @body.present?

    request.body.rewind if request.body.respond_to?(:rewind)

    @body
  end

  def upgrade_account
    if signed_request_account.ostatus?
      signed_request_account.update(last_webfingered_at: nil)
      ResolveAccountWorker.perform_async(signed_request_account.acct)
    end

    DeliveryFailureTracker.reset!(signed_request_account.inbox_url)
  end

  def process_collection_synchronization
    raw_params = request.headers['Collection-Synchronization']
    return if raw_params.blank? || ENV['DISABLE_FOLLOWERS_SYNCHRONIZATION'] == 'true'

    # Re-using the syntax for signature parameters
    tree   = SignatureParamsParser.new.parse(raw_params)
    params = SignatureParamsTransformer.new.apply(tree)

    ActivityPub::PrepareFollowersSynchronizationService.new.call(@signed_request_account, params)
  rescue Parslet::ParseFailed
    Rails.logger.warn 'Error parsing Collection-Synchronization header'
  end

  def process_payload
    Rails.logger.info "Calling process Payload with body: #{body}, and Account.id: #{@account.id}"
    ActivityPub::ProcessingWorker.perform_async(@signed_request_account.id, body, @account&.id)
  end
end
