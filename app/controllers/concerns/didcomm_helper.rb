# frozen_string_literal: true

module DidcommHelper
  extend ActiveSupport::Concern

  JWT_SUFFIX = "ey"

  attr_accessor :signed_request_account

  included do
    before_action :decrypt_payload!, if: :encrypted?
    before_action :set_didcomm_account, if: :encrypted?
  end

  def decrypt_payload!
    service = Did::DidcommService.new(payload: @raw_data,
                                      to_account: set_didcomm_account,
                                      direction: :incoming)
    
    @verified_data, @signed_request_account = service.verified_payload_and_signer

    Rails.logger.info "------------Verified_data: #{@verified_data}"
  end
  
  private
  
  def set_didcomm_account
    @account ||= Account.find_by(display_name: "alice")
  end
end
