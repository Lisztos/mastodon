# frozen_string_literal: true

class ResolveAccountWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'pull', lock: :until_executed

  def perform(uri)
    if uri.include?(Did::DID_PREFIX)
      Did::ResolveAccountService.new.call(uri)
    else
      ResolveAccountService.new.call(uri)
    end
  end
end
