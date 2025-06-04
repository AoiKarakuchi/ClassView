class CreateSubjects < ActiveRecord::Migration[8.0]
  def change
    create_table :subjects do |t|
      t.string :number,null: false
      t.string :name,null: false

      t.timestamps null: false
    end
    add_index :subjects, :number, unique: true
  end
end
