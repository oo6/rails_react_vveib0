class MicropostExpandSerializer < MicropostDetailSerializer
  attributes :source

  def source
    MicropostSerializer.new(object.source, root: false)
  end
end