class CreateGoalCategories < ActiveRecord::Migration
  def change
    create_table :goal_categories do |t|
      t.references :goal, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
