class UserDetailSerializer < UserInfoSerializer
  attributes :microposts_count, :following_count, :followers_count
end
