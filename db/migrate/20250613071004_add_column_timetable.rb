class AddColumnTimetable < ActiveRecord::Migration[8.0]
  def change
    add_column :timetables, :note, :string
  end
end
