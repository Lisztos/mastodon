# frozen_string_literal: true

module WellKnown
  class DidController < ActionController::Base

    before_action :set_account

  def show
    expires_in 1.second
    render json: @account, serializer: Did::DidDocumentSerializer, content_type: 'application/did+json'
  end

  private 

  def set_account
    @account = Account.find_local!("did:web:lisztos.com")
  end

  end
end
