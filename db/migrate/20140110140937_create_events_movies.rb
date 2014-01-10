class CreateEventsMovies < ActiveRecord::Migration
  def self.up
    create_table :events_movies, :id => false do |t|
		t.integer :event_id, :null => false
		t.integer :movie_id, :null => false
    end
	
	add_index :events_movies, [:event_id, :movie_id], :unique => true
  end
  
  def self.down
	remove_index :events_movies, :column => [:event_id, :movie_id]
	drop_table :events_movies
  end
end
