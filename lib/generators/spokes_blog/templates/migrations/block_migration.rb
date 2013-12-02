class CreateBlock < ActiveRecord::Migration
  def change
    create_table :spokes_blog_blocks do |t|
      t.text        :content
      t.integer     :position
      t.integer     :post_id

      t.timestamps
    end
  end
end

