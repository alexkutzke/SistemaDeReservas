class CreateKlasses < ActiveRecord::Migration[5.0]
  def change
    create_table :klasses do |t|
      t.string :name
      t.references :period, foreign_key: true, null: false
      t.timestamps
    end
  end
end
