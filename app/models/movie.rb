class Movie < ActiveRecord::Base
	has_and_belongs_to_many :events

	validates :movie_name, presence: true
end