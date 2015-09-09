class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :micropost_id, :user, :created_at

  def user
    UserSerializer.new(object.user, root: false)
  end
end
