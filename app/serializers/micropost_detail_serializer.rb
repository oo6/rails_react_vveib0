class MicropostDetailSerializer < MicropostSerializer
  attributes :created_at, :comments_count, :likes_count
end