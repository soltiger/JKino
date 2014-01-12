class AddParticipantCountToEvents < ActiveRecord::Migration
  def change
	add_column :events, :participantCount, :integer
  end
end
