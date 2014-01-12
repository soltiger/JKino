class Event < ActiveRecord::Base
	has_and_belongs_to_many :movies
	
	scope :desc, order("events.event_date DESC")
	scope :asc, order("events.event_date ASC")
	
	validates :event_date, presence: true
	validates :event_name, presence: true, uniqueness: true
end