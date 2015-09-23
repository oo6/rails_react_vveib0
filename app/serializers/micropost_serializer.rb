class MicropostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user, :created_at

  def user
    UserInfoSerializer.new(object.user, root: false)
  end
end
