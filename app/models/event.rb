class Event < ActiveRecord::Base
  validates :name, length: { minimum: 2 }

  belongs_to :user
end
