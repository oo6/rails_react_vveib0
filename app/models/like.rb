class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true, counter_cache: true
  has_many :notifications, as: 'subject', dependent: :delete_all

  default_scope -> { order(created_at: :desc) }

  validates :user_id, :subject, presence: true
end
