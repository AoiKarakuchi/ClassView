class CreateSubjectHeldClassrooms < ActiveRecord::Migration[8.0]
  def change
    create_table :subject_held_classrooms do |t|
      t.string :subject_number, null: false
      t.string :classrooms_name, null: false
      t.timestamps null: false
    end
    add_foreign_key :subject_held_classrooms, :subjects, column: :subject_number, primary_key: :number
    add_foreign_key :subject_held_classrooms, :classrooms, column: :classrooms_name, primary_key: :name
  end
end
