class CreatePost < ActiveRecord::Migration
  def change
    create_table :spokes_blog_posts do |t|
      t.string      :template
      t.text        :description
      t.string      :title
      t.string      :slug, index: true, unique: true
      t.text        :excerpt
      t.integer     :state
      t.references  :created_by, index: true
      t.references  :author, index: true

      t.timestamps
    end
  end
end

