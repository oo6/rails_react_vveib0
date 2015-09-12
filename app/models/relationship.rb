class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User", counter_cache: :following_count
  belongs_to :followed, class_name: "User", counter_cache: :followers_count

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
