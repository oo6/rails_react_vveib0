class Topic < ActiveRecord::Base
  has_many :topic_relationships, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
end
