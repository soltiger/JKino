class Event < ActiveRecord::Base
	has_and_belongs_to_many :movies
	
	validates :event_date, presence: true
	validates :event_name, presence: true, uniqueness: true
end