class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true, counter_cache: true

  default_scope -> { order(created_at: :desc) }

  validates :user_id, :subject, presence: true
end
