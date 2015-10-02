class CommentSerializer < ActiveModel::Serializer
  include LikedHelper
  attributes :id, :content, :micropost_id, :user, :created_at, :likes_count, :liked

  def user
    UserInfoSerializer.new(object.user, root: false)
  end
end
