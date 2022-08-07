# frozen_string_literal: true

class ActivityPub::DistributionWorker < ActivityPub::RawDistributionWorker
  # Distribute a new status or an edit of a status to all the places
  # where the status is supposed to go or where it was interacted with
  def perform(status_id)
    @status  = Status.find(status_id)
    @account = @status.account

    Rails.logger.info "DistributionWorker.......Encrypted Payload: #{payload}"
    
    distribute!
  rescue ActiveRecord::RecordNotFound
    true
  end

  protected

  def inboxes
    @inboxes ||= status_reacher.inboxes
  end

  def target_account
    status_reacher.direct_target_account
  end

  def payload
    @payload = didcommize_payload(activitypub_payload) if @status.direct_visibility?

    @payload ||= activitypub_payload
  end

  def activitypub_payload
    Oj.dump(serialize_payload(activity, ActivityPub::ActivitySerializer, signer: @account))
  end

  def didcommize_payload(payload)
    Rails.logger.info "is Payload empty? #{payload}"
    service = Did::DidcommService.new(payload, target_account)
    
    return service.encrypted_payload
  end

  def activity
    ActivityPub::ActivityPresenter.from_status(@status)
  end

  def options
    { 'synchronize_followers' => @status.private_visibility? }
  end

  private

  def status_reacher
    @status_reacher ||= StatusReachFinder.new(@status)
  end
end
