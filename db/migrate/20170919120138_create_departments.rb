class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :abbreviation
      t.string :code
      t.string :place

      t.timestamps
    end
  end
end
