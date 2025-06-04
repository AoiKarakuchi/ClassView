class CreateUserRegistSubjects < ActiveRecord::Migration[8.0]
  def change
    create_table :user_regist_subjects do |t|
      t.string :user_email, null: false
      t.string :subject_number, null: false


      t.timestamps null: false
    end
    add_foreign_key :user_regist_subjects, :users, column: :user_email, primary_key: :email
    add_foreign_key :user_regist_subjects, :subjects, column: :subject_number, primary_key: :number
    add_index :user_regist_subjects,[:user_email, :subject_number], unique: true
  end
end
