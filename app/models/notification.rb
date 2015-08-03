class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true

  default_scope -> { order(created_at: :desc) }
  scope :named, -> (name) { where(name: name) }
  scope :unread, -> { where(read: false) }

  validates :user_id, presence: true
  validates :subject, presence: true
  validates :name, presence: true
end
