class SpokesBlog::PostsController < ApplicationController
  around_filter :check_if_record_found, only: :show

  def index
    @posts = SpokesBlog::Post.published.page(params[:page]).per(10)
  end

  def show
    @presenter = SpokesBlog::Post.post_presenter.single_post(slug: params[:slug])
  end

  private

  def post_presenter
    @post_presenter || @post_presenter = PostPresenter.new
  end

  def check_if_record_found 
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      #this should be handled in application controller
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end

