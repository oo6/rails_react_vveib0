class UserSerializer < ActiveModel::Serializer
  attributes :avatar_url

  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(object.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
