class RubyGemsController < ApplicationController
  def index
    render json: RubyGem.all.limit(user_limit)
  end

  private

  def user_limit
    params[:limit].presence || 10
  end
end
