class CreateKlasses < ActiveRecord::Migration[5.0]
  def change
    create_table :klasses do |t|
      t.string :name
      t.references :period, foreign_key: true

      t.timestamps
    end
    add_index :klasses, :name, unique: true
  end
end
