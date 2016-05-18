class UserDetailSerializer < UserInfoSerializer
  delegate :current_user, to: :scope
  attributes :microposts_count, :following_count, :followers_count, :following

  def following
    current_user.following?(object)
  end
end
