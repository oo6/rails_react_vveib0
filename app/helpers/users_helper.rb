module UsersHelper
  # 返回指定用户的 Gravatar
  def portrait_url(user)
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    return gravatar_url
  end
end
