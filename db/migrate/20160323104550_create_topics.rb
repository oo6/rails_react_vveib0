class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :content, index: true
      t.text :guide
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
