class Did::FetchDidcommKeyService < BaseService

  def call(did, options= {})
    Rails.logger.info "Fetching DIDComm key for DID: #{did}"
    initialize_options!(did, options)

    return did_document.rsa_didcomm_key
  end

  def initialize_options!(did, options)
    @options = options
    @did = did
  end

  def did_document
    resolver = Did::DidResolverService.instance
    json = resolver.resolve(did: @did)
    Rails.logger.info "DID Document fetched: #{json}}"
    @did_document ||= DidDocument.new(json)
  end


end
