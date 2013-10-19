class VersionsController < ApplicationController
  before_action :wait_for_it

  def index
    ruby_gem = find_ruby_gem
    versions = ruby_gem.versions

    render json: versions
  end

  def show
    ruby_gem = find_ruby_gem
    version = ruby_gem.versions.find_by(number: params[:id])

    render json: version
  end

  private

  def find_ruby_gem
    RubyGem.friendly.find(params[:ruby_gem_id])
  end

  def wait_for_it
    @ruby_gem = find_ruby_gem
  rescue ActiveRecord::RecordNotFound
    raise params[:ruby_gem_id].inspect
    FetchGemWorker.perform_async(params[:ruby_gem_id])

    render json: { status: "wait" }
  end
end
