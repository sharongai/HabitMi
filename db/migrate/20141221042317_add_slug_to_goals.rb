class AddSlugToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :slug, :string
    add_index :goals, :slug, unique: true
  end
end
