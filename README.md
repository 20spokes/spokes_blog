# SpokesBlog

This gem adds a very simple blog skeleton to your Rails application. It requires an authentication system or anything that implements a `current_user` method and requires manual implementation of authentication/authorization in `controllers/admin/posts_controller.rb`.

By default it adds `acts-as-taggable-on`, `kaminari`, and `haml` to your Gemfile, but those can be removed after installation if desired. The default views are very bare, serving more as a simple code example. `jquery.Datables` plugin is not included!

The main model is `post.rb`, which `has_many` blocks, which hold the actual text content. It's fine to use a single block per post, but having many blocks per post make structuring content more flexible. There's also an SeoMeta model, which holds basic seo-related information and can be attatched to posts or blocks and later used in a view via a presenter.

### Installation

The gem assumes a User model and table already exist, so all that's needed is:

    rails g spokes_blog
    bundle install
    rake db:migrate

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


