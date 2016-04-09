class Picture < ActiveRecord::Base
  belongs_to :subject, polymorphic: true

  validates :key, presence: true
end
