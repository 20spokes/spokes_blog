class SpokesBlog::PostPresenter < Presenter

  def single_post(params = {})
    @post = Post.includes(:author).includes(:blocks).by_slug(params[:slug])
    self
  end

  def title
    @post.title
  end

  def author
    @post.author.full_name
  end

  def content
    @post.blocks
  end

  def published_at
    @post.updated_at.strftime("%A, %b %d, %Y")
  end
end

