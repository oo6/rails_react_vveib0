class AddNotificationSettingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mentions_permission, :string, default: 'all'
    add_column :users, :comments_permission, :string, default: 'all'
    add_column :users, :likes_permission, :boolean, default: true
  end
end
