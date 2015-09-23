class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :micropost_id, :user, :created_at

  def user
    UserInfoSerializer.new(object.user, root: false)
  end
end
