class AddScoreToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :score, :integer
  end
end
