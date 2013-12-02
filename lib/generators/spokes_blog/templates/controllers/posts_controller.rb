class SpokesBlog::PostsController < ApplicationController

  def index
    @posts = SpokesBlog::Post.published.page(params[:page]).per(10)
  end

  def show
    @presenter = post_presenter.single_post(slug: params[:slug])
  end

  private

  def post_presenter
    @post_presenter || @post_presenter = PostPresenter.new
  end
end

