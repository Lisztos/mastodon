# frozen_string_literal: true

class Api::V1::Trends::LinksController < Api::BaseController
  before_action :set_links

  def index
    render json: @links, each_serializer: REST::Trends::LinkSerializer
  end

  private

  def set_links
    @links = if Setting.trends
               links_from_trends
             else
               []
             end
  end

  def links_from_trends
    Trends.links.query.allowed.in_locale(content_locale).limit(limit_param(10))
  end
end
