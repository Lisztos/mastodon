# frozen_string_literal: true

module DidcommHelper
  extend ActiveSupport::Concern

  JWT_SUFFIX = "ey"

  attr_accessor :signed_request_account

  included do
    before_action :decrypt_payload!, if: :encrypted?
  end

  def decrypt_payload!
    service = Did::DidcommService.new(payload: request.raw_post,
                                      to_account: receiver_account,
                                      direction: :incoming)
    
    @verified_data, @signed_request_account = service.verified_payload_and_signer
  end
  
  private
  
  def receiver_account
    Account.find_by(display_name: "alice")
  end
end
