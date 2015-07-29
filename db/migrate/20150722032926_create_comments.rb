class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, index: true
      t.references :micropost, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :microposts
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:micropost_id, :created_at]
  end
end
