class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true

  validates :user_id, :subject, presence: true
end
