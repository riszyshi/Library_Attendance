class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :usn, null: false, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
