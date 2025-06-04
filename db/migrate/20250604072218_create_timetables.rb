class CreateTimetables < ActiveRecord::Migration[8.0]
  def change
    create_table :timetables do |t|
      t.string :semester, null: 
      t.string :dayofweek, null: false
      t.string :hour, null: false


      t.timestamps null: false
    end
  end
end
