# frozen_string_literal: true

class Did::ResolveAccountService < BaseService
  include JsonLdHelper

  # Find or create an account record for a remote user. When creating,
  # look up the user's DID Document and fetch ActivityPub data
  # @param [String, Account] did in the did:method:asdfg
  # @param [Hash] options
  # @return [Account]
  def call(did, options = {})
    return if did.blank?

    initialize_options!(did, options)

    # First of all we want to check if we've got the account
    # record with the URI already, and if so, we can exit early

    @account ||= Did.find_remote(@username)

    return @account if @account.present?

    # At this point we are in need of a DID Resolution, which may
    # yield us a different username/domain through a redirect
    process_did!(@did)

    # Because the username may be different than what
    # we already checked, we need to check if we've already got
    # the record with that URI, again

    @account ||= Did.find_remote(@did)

    return @account if @account.present?

    # Now it is certain, it is definitely a remote account, and it
    # either needs to be created, or updated from fresh data

    fetch_account!
  rescue Did::DidResolverService::DIDNotFoundError => e
    Rails.logger.debug "DID query for #{@did} failed: #{e}"
    nil
  end

  private

  def initialize_options!(did, options)
    @options = options
    @did = did
    @domain = nil
  end

  def process_did!(did)
    json = get_did_document
    did_document = DidDocument.new(json)
    @actor_url = did_document.activitypub_endpoint
    Rails.logger.info "ACTOR URL: #{@actor_url}"
  end
  
  def get_did_document
    resolver = Did::DidResolverService.instance
    resolver.resolve(did: @did)
  end

  def fetch_account!
    RedisLock.acquire(lock_options) do |lock|
      if lock.acquired?
        Rails.logger.info "Calling Did::ActivityPub::FetchRemoteAccountService...."
        @account = Did::ActivityPub::FetchRemoteAccountService.new.call(@actor_url)
      else
        raise Mastodon::RaceConditionError
      end
    end

    @account
  end

  def not_yet_deleted?
    @account.present?
  end

  def queue_deletion!
    @account.suspend!(origin: :remote)
    AccountDeletionWorker.perform_async(@account.id, { 'reserve_username' => false, 'skip_activitypub' => true })
  end

  def lock_options
    { redis: Redis.current, key: "resolve:#{@did}", autorelease: 15.minutes.seconds }
  end
end
