# frozen_string_literal: true

class Did::ActivityPub::FetchRemoteAccountService < BaseService
  include JsonLdHelper
  include DomainControlHelper

  SUPPORTED_TYPES = %w(Application Group Organization Person Service).freeze

  def call(uri, id: true, prefetched_body: nil, break_on_redirect: false)

    return ActivityPub::TagManager.instance.uri_to_resource(uri, Account) if ActivityPub::TagManager.instance.local_uri?(uri)

    @json = if prefetched_body.nil?
            fetch_resource(uri, id)
          else
            body_to_json(prefetched_body, compare_id: id ? uri : nil)
            end

    return if !supported_context? || !expected_type? || (break_on_redirect && @json['movedTo'].present?)
    
    @uri      = @json['id']
    @username = @json['preferredUsername']
    @domain   = parse_domain
  
    ActivityPub::ProcessAccountService.new.call(@username, @domain, @json)
  rescue Oj::ParseError
    nil
  end

  private

  def parse_domain
    URI.parse(@json['id']).host
  end

  def supported_context?
    super(@json)
  end

  def expected_type?
    equals_or_includes_any?(@json['type'], SUPPORTED_TYPES)
  end
end
