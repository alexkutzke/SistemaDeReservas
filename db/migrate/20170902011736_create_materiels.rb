class CreateMateriels < ActiveRecord::Migration[5.0]
  def change
    create_table :materiels do |t|
      t.string :name
      t.string :patrimony
      t.references :room, foreign_key: true, null: true

      t.timestamps
    end
  end
end
