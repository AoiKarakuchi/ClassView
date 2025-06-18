class AddColumnTables < ActiveRecord::Migration[8.0]
  def change
    add_column :user_regist_subjects, :year, :integer
    add_column :subject_open_timetables, :year, :integer
  end
end
