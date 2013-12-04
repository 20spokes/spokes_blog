class SpokesBlog::PostPresenter < Presenter

  def single_post(params = {})
    @post = SpokesBlog::Post.includes(:author).includes(:blocks).includes(:seo_meta).by_slug(params[:slug])
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

  def browser_title
    @post.seo_meta.browser_title
  end

  def meta_description
    @post.seo_meta.meta_description
  end
end

