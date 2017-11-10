class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :abbreviation
      t.string :code
      t.references :sector, foreign_key: true, null: false
      t.timestamps
    end
  end
end
