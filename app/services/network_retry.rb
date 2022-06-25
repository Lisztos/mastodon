class NetworkRetry
  attr_accessor :exponential_base, :sleep_interval

  def initialize(max_retry: 3, exponential: 2)
    @exponential = exponential
    @max_retry = max_retry
    @sleep_interval = Proc.new { |retry_count| @exponential**retry_count }
  end

  def non_500_filter()
    Proc.new do |error|
      !(
        error.is_a?(RestClient::RequestTimeout) ||
        (error.is_a?(RestClient::RequestFailed) && error.http_code > 499)
      )
    end
  end

  def ensure(error_filter: nil)
    retry_count = 0

    begin
      yield
    rescue => error
      if (error_filter.present? && error_filter.call(error)) || retry_count == @max_retry
        raise error
      end

      retry_count += 1
      sleep @sleep_interval.call(retry_count)
      retry
    end
  end
end
