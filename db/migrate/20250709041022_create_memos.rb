class CreateMemos < ActiveRecord::Migration[8.0]
  def change
    create_table :memos do |t|
      t.text :content
      t.string :user_email

      t.timestamps
    end
    add_index :memos, [:user_email, :created_at]
  end
end