class User < ActiveRecord::Base
  has_many :authored_posts, class_name: :'SpokesBlog::Post', foreign_key: :author_id
  has_many :created_posts, class_name: :'SpokesBlog::Post', foreign_key: :created_by_id

end
