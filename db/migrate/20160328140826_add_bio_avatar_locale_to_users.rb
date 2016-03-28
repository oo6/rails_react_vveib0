class AddBioAvatarLocaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :avatar, :string
    add_column :users, :locale, :string
  end
end
