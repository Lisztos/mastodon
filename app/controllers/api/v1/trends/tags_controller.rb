# frozen_string_literal: true

class Api::V1::Trends::TagsController < Api::BaseController
  before_action :set_tags

  def index
    render json: @tags, each_serializer: REST::TagSerializer
  end

  private

  def set_tags
    @tags = if Setting.trends
              Trends.tags.query.allowed.limit(limit_param(10))
            else
              []
            end
  end
end
