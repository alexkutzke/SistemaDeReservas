class CreateMateriels < ActiveRecord::Migration[5.0]
  def change
    create_table :materiels do |t|
      t.string :name
      t.string :patrimony
      t.string :serial_number 
      t.references :classroom, foreign_key: true, null: true

      t.timestamps
    end
  end
end
