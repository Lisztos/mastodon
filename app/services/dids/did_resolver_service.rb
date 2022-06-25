# frozen_string_literal: true

class Dids::DidResolverService

  attr_accessor :requester

  def initialize
    @requester = RestClient::Request
    @url = "http://127.0.0.1:5080/1.0/identifiers/"
    @retry_client = NetworkRetry.new

    @headers = {
      content_type: :json,
      accept: :json
    }
  end

  def resolve(did:)
    execute_wrapper(
      method: :get,
      url: @url + did,
      headers: @headers,
    )
  end

  private

  def execute_wrapper(**args)
    error_filter = @retry_client.non_500_filter

    @retry_client.ensure(error_filter: error_filter) { requester.execute(**args) }
  rescue => error
    Rails.logger.error error.response.body
  end
end
