class Did::DidResolverService < BaseService
  class InvalidDidError < StandardError; end
  class DIDNotFoundError < StandardError; end

  attr_accessor :requester

  def initialize
    @requester = RestClient::Request
    @url = "http://did-resolver:8080/1.0/identifiers/"
    @retry_client = NetworkRetry.new

    @headers = {
      content_type: :json,
      accept: :json
    }
  end

  def resolve(did:)
    res = execute_wrapper(
      method: :get,
      url: @url + did,
      headers: @headers,
    )
    throw DIDNotFoundError if res == 1

    JSON.parse(res.body)
  end

  private

  def execute_wrapper(**args)
    error_filter = @retry_client.non_500_filter

    @retry_client.ensure(error_filter: error_filter) { requester.execute(**args) }
  rescue => error
    Rails.logger.error error.response.body
  end
end
