class Event < ActiveRecord::Base
  extend EventRepository
  validates :name, length: { minimum: 2 }

  belongs_to :user
end
