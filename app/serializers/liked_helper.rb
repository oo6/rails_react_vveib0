module LikedHelper
  delegate :current_user, to: :scope
  
  def liked
    object.liked_by?(current_user)
  end
end
