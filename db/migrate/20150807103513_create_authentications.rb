class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :provider
      t.references :user

      t.timestamps null: false
    end
    add_foreign_key :authentications, :users
    add_index :authentications, [:uid, :provider], unique: true
  end
end
