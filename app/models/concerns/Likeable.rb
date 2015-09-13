module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: 'subject', dependent: :destroy
  end

  def liked_by?(user)
    likes.where(user: user).exists?
  end
end
