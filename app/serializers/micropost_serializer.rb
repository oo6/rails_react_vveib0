class MicropostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user

  def user
    UserInfoSerializer.new(object.user, root: false)
  end
end
