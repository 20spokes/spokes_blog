class SpokesBlog::Post < ActiveRecord::Base
  self.table_name_prefix = "spokes_blog_"
  include Pageable
  acts_as_taggable

  belongs_to :created_by, class_name: User
  belongs_to :author, class_name: User
  has_many :blocks, class_name: :'SpokesBlog::Block'
  has_one :seo_meta, as: :seo_meta, class_name: :'SpokesBlog::SeoMeta'

  accepts_nested_attributes_for :blocks,
    reject_if: lambda { |attrs| attrs['content'].blank? }

  accepts_nested_attributes_for :seo_meta

  validates_presence_of :title, :slug

  validates_format_of :slug, with: /\A[a-zA-Z0-9-]+\z/

end
