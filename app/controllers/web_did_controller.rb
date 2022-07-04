class WebDidController < ActionController::Base

  before_action :set_account

  def show
    if @account.nil?
      head 404
      return
    end

    expires_in 1.second
    render json: @account, serializer: Did::DidDocumentSerializer, content_type: 'application/did+json'
  end

  private 

  def set_account
    name = params[:username].try(:downcase)
    @account = Account.find_local!(name)

  rescue ActiveRecord::RecordNotFound
    if @account.nil?
      @account = Account.where("LOWER(display_name) = ?", name).take
    end
  end
end
