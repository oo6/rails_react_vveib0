class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url

  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(object.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
