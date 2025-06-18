#class CreateSubjectHeldClassrooms < ActiveRecord::Migration[8.0]
  #def change
    #create_table :subject_held_classrooms do |t|
      #t.string :subject_number, null: false
      #t.string :classroom_name
      #t.timestamps null: false
    #end
    #add_foreign_key :subject_held_classrooms, :subjects, column: :subject_number, primary_key: :number
    #add_foreign_key :subject_held_classrooms, :classrooms, column: :classroom_name, primary_key: :name
  #end
#end

class CreateSubjectHeldClassrooms < ActiveRecord::Migration[7.1]
  def up
    create_table :subject_held_classrooms do |t|
      t.string :subject_number, null: false
      t.string :classroom_name
      t.integer :year
      t.timestamps null: false
    end

    add_foreign_key :subject_held_classrooms, :classrooms, column: :classroom_name, primary_key: :name
  end

  def down
    remove_foreign_key :subject_held_classrooms, column: :classroom_name rescue nil
    drop_table :subject_held_classrooms
  end
end

