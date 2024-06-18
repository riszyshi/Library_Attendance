class AddAttributesToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :age, :integer
    add_column :students, :address, :string
    add_column :students, :emergency_contact_name, :string
    add_column :students, :emergency_contact_number, :string
    add_column :students, :birthdate, :date
    add_column :students, :year, :string
    add_column :students, :course, :string
    add_column :students, :contact_number, :integer
  end
end
