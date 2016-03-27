class Comment < ActiveRecord::Base
  include Likeable
  include Mentionable

  has_ancestry

  belongs_to :user
  belongs_to :micropost, counter_cache: true
  has_many :notifications, as: 'subject', dependent: :delete_all

  has_many :topic_relationships, as: 'subject', dependent: :delete_all

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  after_destroy :delete_all_notifications

  def delete_all_notifications
    notifications.delete_all
  end
end
