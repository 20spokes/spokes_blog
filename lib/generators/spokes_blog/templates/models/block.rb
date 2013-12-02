class SpokesBlog::Block < ActiveRecord::Base
  self.table_name_prefix = "spokes_blog_"
  belongs_to :post, class_name: :'SpokesBlog::Post'

  validates_presence_of :content

end
