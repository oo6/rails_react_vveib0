class Micropost < ActiveRecord::Base
  include Likeable
  include Mentionable

  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :notifications, as: 'subject', dependent: :delete_all

  # 自连接
  has_many :expands, class_name: "Micropost",
                          foreign_key: "source_id"
  belongs_to :source, class_name: "Micropost"

  has_many :topic_relationships, as: 'subject', dependent: :delete_all
  has_many :pictures, as: 'subject', dependent: :delete_all

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def is_expand?
    source_id != 0 ? true : false
  end
end
