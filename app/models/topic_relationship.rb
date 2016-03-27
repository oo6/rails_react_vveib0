class TopicRelationship < ActiveRecord::Base
  belongs_to :topic
  belongs_to :subject, polymorphic: true
end
