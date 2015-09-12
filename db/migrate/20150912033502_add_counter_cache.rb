class AddCounterCache < ActiveRecord::Migration
  def change
    add_column :users, :microposts_count, :integer, default: 0
    add_column :users, :following_count, :integer, default: 0
    add_column :users, :followers_count, :integer, default: 0
    add_column :microposts, :comments_count, :integer, default: 0
    add_column :microposts, :likes_count, :integer, default: 0
    add_column :comments, :likes_count, :integer, default: 0
  end
end
