class Event < ActiveRecord::Base
	has_and_belongs_to_many :movies
	
	validates :event_date, presence: true
end
