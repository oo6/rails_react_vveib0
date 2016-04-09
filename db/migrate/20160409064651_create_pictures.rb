class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :key
      t.references :subject, polymorphic: true, index: true

      t.timestamps
    end
  end
end
