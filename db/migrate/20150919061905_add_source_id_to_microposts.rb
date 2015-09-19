class AddSourceIdToMicroposts < ActiveRecord::Migration
  def change
     add_column :microposts, :source_id, :integer, default: 0
  end
end
