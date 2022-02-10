class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.date :date_of_birth
      t.integer :phone_number
      t.string :major

      t.timestamps
    end
    add_index :students, :email, unique: true
  end
end
