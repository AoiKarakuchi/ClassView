class CreateSubjectOpenTimetables < ActiveRecord::Migration[8.0]
  def change
    create_table :subject_open_timetables do |t|
      t.string :subject_number, null: false
      t.references :timetable_id, null: false, foreign_key: true
      t.timestamps null: false
    end
    add_foreign_key :subject_open_timetables, :subjects, column: :subject_number, primary_key: :number
  end
end
