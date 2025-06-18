class CreateClassrooms < ActiveRecord::Migration[8.0]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.float :latitude
      t.float :longitude


      t.timestamps null: false
    end
    add_index :classrooms, :name, unique: true
  end
end
