class DropStudentClasses < ActiveRecord::Migration[5.0]
  def change
    drop_table :student_classes
  end
end
