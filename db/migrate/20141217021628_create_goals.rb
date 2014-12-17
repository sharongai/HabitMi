class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :user, index: true
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.references :category, index: true

      t.timestamps
    end
  end
end
