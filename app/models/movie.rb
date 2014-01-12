class Movie < ActiveRecord::Base
	has_and_belongs_to_many :events

	scope :desc, order("movies.movie_name DESC")
	scope :asc, order("movies.movie_name ASC")

	validates :movie_name, presence: true
end