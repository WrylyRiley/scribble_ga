class Post < ActiveRecord::Base
  default_scope { order('updated_at DESC') } # sorts by updated at in reverse orderr
  belongs_to :user
  has_many :comments
end
