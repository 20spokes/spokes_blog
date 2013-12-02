class CreateSeoMeta < ActiveRecord::Migration
  def change
    create_table :seo_meta do |t|
      t.string    :browser_title
      t.string    :meta_description
      t.integer   :seo_meta_id
      t.string    :seo_meta_type

      t.timestamps
    end
    add_index :seo_meta, [:seo_meta_id, :seo_meta_type]
  end
end

