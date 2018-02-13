class Comment < ActiveRecord::Base
  default_scope { order('updated_at DESC') } # sorts by updated at in reverse orderr
  belongs_to :post
  belongs_to :user
end
