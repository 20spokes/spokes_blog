class Admin::SpokesBlog::PostsController < ApplicationController

  def index
    @posts = SpokesBlog::Post.all
  end

  def new
    @post = SpokesBlog::Post.new
    @post.blocks << SpokesBlog::Block.new
  end

  def create
    @post = SpokesBlog::Post.new(post_params)

    @post.created_by_id = current_user.id

    if @post.save
      redirect_to edit_admin_post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = SpokesBlog::Post.find(params[:id])
  end

  def update
    @post = SpokesBlog::Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to edit_admin_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = SpokesBlog::Post.find(params[:id])

    @post.destroy

    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:spokes_blog_post).permit(:title, :slug, :description, :tag_list,
                                 :author_id, blocks_attributes: [:content, :id])
  end
end

