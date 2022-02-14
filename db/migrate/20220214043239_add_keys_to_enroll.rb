class AddKeysToEnroll < ActiveRecord::Migration[7.0]
  def change
    # add_column :studentid, :string
    # add_foreign_key :enrolls, :students, column: :studentid, primary_key: :student_id
    # add_reference :enrolls, column: :student_id, foreign_key: { to_table: :students }

    add_column :enrolls, :course_id, :string, index: true
    add_column :enrolls, :student_id, :string, index: true

    add_foreign_key :enrolls, :courses, column: :course_id, primary_key: :code
    add_foreign_key :enrolls, :students, column: :student_id, primary_key: :student_id


  end
end
