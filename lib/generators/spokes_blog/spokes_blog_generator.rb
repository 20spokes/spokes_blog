require 'rails/generators'
module SpokesBlog
  module Generators
    class SpokesBlogGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :layout_name, type: :string, default: "application"

      def take_care_of_acts_as_taggable_on_migration
        generate "acts_as_taggable_on:migration"
      end

      def copy_models_and_concerns
        copy_file "models/block.rb", "app/models/spokes_blog/block.rb"
        copy_file "models/post.rb", "app/models/spokes_blog/post.rb"
        copy_file "models/seo_meta.rb", "app/models/spokes_blog/seo_meta.rb"
        copy_file "models/concerns/pageable.rb", "app/models/spokes_blog/concerns/pageable.rb"
      end


      def copy_controllers
        copy_file "controllers/admin/posts_controller.rb", "app/controllers/admin/spokes_blog/posts_controller.rb"
        copy_file "controllers/posts_controller.rb", "app/controllers/spokes_blog/posts_controller.rb"
      end

      def copy_admin_views
        copy_file "views/admin/index.html.haml", "app/views/admin/spokes_blog/posts/index.html.haml"
        copy_file "views/admin/index.json.jbuilder", "app/views/admin/spokes_blog/posts/index.json.jbuilder"
        copy_file "views/admin/new.html.haml", "app/views/admin/spokes_blog/posts/new.html.haml"
        copy_file "views/admin/_form.html.haml", "app/views/admin/spokes_blog/posts/_form.html.haml"
        copy_file "views/admin/_block_content_form.html.haml", "app/views/admin/spokes_blog/posts/_block_content_form.html.haml"
        copy_file "views/admin/_seo_meta_form.html.haml", "app/views/admin_spokes_blog/posts/_seo_meta_form.html.haml"
      end

      def copy_user_views
        copy_file "views/index.html.haml", "app/views/spokes_blog/posts/index.html.haml"
        copy_file "views/show.html.haml", "app/views/spokes_blog/posts/show.html.haml"
      end


      def copy_presenters
        copy_file "presenters/presenter.rb", "app/presenters/spokes_blog/presenter.rb"
        copy_file "presenters/post_presenter.rb", "app/presenters/spokes_blog/post_presenter.rb"
      end

      def modify_or_create_user_model
        if File.exist?(Rails.root.join('app', 'models', 'user.rb')) and
          File.readlines(Rails.root.join('app', 'models', 'user.rb')).grep(/authored_posts/).size == 0
          line = "class User < ActiveRecord::Base"
          gsub_file "app/models/user.rb", /(#{Regexp.escape(line)})/mi do |match|
            "#{match}\n  has_many :authored_posts, class_name: :'SpokesBlog::Post', foreign_key: :author_id\n  has_many :created_posts, class_name: :'SpokesBlog::Post', foreign_key: :created_by_id"
          end
        else
          copy_file "models/user.rb", "app/models/user.rb"
        end
      end

      def add_default_routes
        if File.readlines(Rails.root.join('config', 'routes.rb')).grep(/spokes_blog/).size == 0
          line = "::Application.routes.draw do"
          gsub_file Rails.root.join('config', 'routes.rb'), /(#{Regexp.escape(line)})/mi do |match|
            %{#{match}
  namespace :admin do
    scope module: 'spokes_blog' do
      resources :posts
    end
  end

  scope module: 'spokes_blog' do
    resources :posts, only: [:index]
  end
  get "/posts/:slug" => "spokes_blog/posts#show", as: :post_slug
  }
          end
        end
      end

      def add_spokes_blog_models_to_load_path
        if File.readlines(Rails.root.join("config", "application.rb")).grep(/spokes_blog config/).size == 0
          line = "class Application < Rails::Application"
          gsub_file Rails.root.join("config", "application.rb"), /(#{Regexp.escape(line)})/mi do |match|
            %{#{match}
    # spokes_blog config
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**/}')]}
          end
        end
      end

      def add_gems_to_gem_file
        %w(acts-as-taggable-on haml kaminari).each do |gem|
          add_gem_entry_to_gemfile(gem)
        end
      end

      def create_migrations
        @migration_count = 10
        if Dir.glob("db/migrate/*_create_post.rb").empty?
          #sleep(1)
          copy_file "migrations/post_migration.rb", "db/migrate/#{migration_timestamp}_create_post.rb"
        end
        if Dir.glob("db/migrate/*_create_block.rb").empty?
          #sleep(1)
          copy_file "migrations/block_migration.rb", "db/migrate/#{migration_timestamp}_create_block.rb"
        end
        if Dir.glob("db/migrate/*_create_seo_meta.rb").empty?
          #sleep(1)
          copy_file "migrations/seo_meta_migration.rb", "db/migrate/#{migration_timestamp}_create_seo_meta.rb"
        end
      end

      private

      def migration_timestamp
        migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        migration_number += @migration_count
        @migration_count += 1
        migration_number.to_s
      end

      def add_gem_entry_to_gemfile(gemname)
        if File.readlines(Rails.root.join("Gemfile")).grep(/#{gemname}/).size == 0
          line = "rubygems.org'"
          gsub_file Rails.root.join("Gemfile"), /(#{Regexp.escape(line)})/mi do |match|
            %{#{match}

gem '#{gemname}'
            }
          end
        end
      end

    end
  end
end

