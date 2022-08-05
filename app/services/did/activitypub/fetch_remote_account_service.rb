# frozen_string_literal: true

class Did::ActivityPub::FetchRemoteAccountService < BaseService
  include JsonLdHelper
  include DomainControlHelper

  SUPPORTED_TYPES = %w(Application Group Organization Person Service).freeze

  # Does a WebFinger roundtrip on each call, unless `only_key` is true
  def call(uri, id: true, prefetched_body: nil, break_on_redirect: false, only_key: false)

    return ActivityPub::TagManager.instance.uri_to_resource(uri, Account) if ActivityPub::TagManager.instance.local_uri?(uri)

    @json = if prefetched_body.nil?
              fetch_resource(uri, id)
            else
              body_to_json(prefetched_body, compare_id: id ? uri : nil)
            end

    return if !supported_context? || !expected_type? || (break_on_redirect && @json['movedTo'].present?)

    @uri      = @json['id']
    @username = @json['preferredUsername']

    return unless only_key 
  
    Rails.logger.info "ActivityPub: Process Account service with: Username#{@username}, domain: nil, @json: #{@json}"
    ActivityPub::ProcessAccountService.new.call(@username, nil, @json, only_key: only_key, verified_webfinger: !only_key)
  rescue Oj::ParseError
    nil
  end

  private

  def supported_context?
    super(@json)
  end

  def expected_type?
    equals_or_includes_any?(@json['type'], SUPPORTED_TYPES)
  end
end
