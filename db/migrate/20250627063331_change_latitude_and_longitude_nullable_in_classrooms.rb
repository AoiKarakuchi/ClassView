class ChangeLatitudeAndLongitudeNullableInClassrooms < ActiveRecord::Migration[8.0]
  def change
    change_column_null :classrooms, :latitude, true
    change_column_null :classrooms, :longitude, true
  end
end

