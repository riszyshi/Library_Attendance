class AddPurposeToAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :purpose, :string
  end
end
