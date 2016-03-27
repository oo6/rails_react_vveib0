class CreateTopicRelationships < ActiveRecord::Migration
  def change
    create_table :topic_relationships do |t|
      t.references :topic, index: true
      t.references :subject, polymorphic: true, index: true

      t.timestamps
    end
    add_foreign_key :topic_relationships, :topics
  end
end
