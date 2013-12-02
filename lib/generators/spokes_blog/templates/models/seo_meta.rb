class SpokesBlog::SeoMeta < ActiveRecord::Base
  belongs_to :seo_meta, polymorphic: true

end

