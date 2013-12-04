# SpokesBlog

We found ourselves implementing blog-like features into many projects, so it was decided that the best thing to do would package these features into a gem to apply them easily to different projects. This means that this gem builds a skeleton of a blog in a Rails 4 application, with a few project specific blanks to fill out, especially the views, which are there to document the api. 

It's still under development, features may not work or break things, but we're working on it ;).

By default it adds `acts-as-taggable-on`, `kaminari`, and `haml` to your Gemfile, but those can be removed after installation if desired. `jquery.Datables` plugin is not included!

The main model is `post.rb`, which `has_many` blocks, which hold the actual text content. It's fine to use a single block per post, but having many blocks per post make structuring content more flexible. There's also an SeoMeta model, which holds basic seo-related information and can be attatched to posts or blocks and later used in a view via a presenter.

### Installation

The gem assumes a User model and table already exist, so all that's needed is:

    rails g spokes_blog
    bundle install
    rake db:migrate

### Customization

1. The post presenter assumes the User model has a `full_name` method, but this can be changed to be something application specific.

2. The post model has both an `author_id` and `created_by_id`. The latter should be set by the controller, whereas the former should be editable.

3. The Pageable concern adds some convenience methods such as searching by slug or an easy mapping (enum?) for document states (draft, published, archived). Check it out!

### Directory Structure

    Controllers:
      admin/spokes_blog/posts_controller.rb - admin ctrl
      spokes_blog/posts_controller.rb - public ctrl
    Models:
      spokes_blog/ - post, block, seo_meta
      spokes_blog/concerns - pageable
    Views (pretty empty, mainly as api documentation)
      admin/spokes_blog/posts
      spokes_blog/posts
    Presenters (presenter pattern)
      presenters/presenter.rb - base presenter class
      presenters/post_presenter.rb

It will also update routes.rb and application rb.


