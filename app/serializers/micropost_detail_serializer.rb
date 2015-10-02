class MicropostDetailSerializer < MicropostSerializer
  include LikedHelper
  attributes :created_at, :comments_count, :likes_count, :liked
end
