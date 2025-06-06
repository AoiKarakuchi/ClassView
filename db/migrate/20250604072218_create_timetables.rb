class CreateTimetables < ActiveRecord::Migration[8.0]
  def change
    create_table :timetables do |t|
      t.string :semester, null: false
      t.string :dayofweek
      t.string :hour


      t.timestamps null: false
    end
  end
end
