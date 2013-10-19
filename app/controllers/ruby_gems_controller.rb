class RubyGemsController < ApplicationController
  def index
    render json: RubyGem.all
  end
end
