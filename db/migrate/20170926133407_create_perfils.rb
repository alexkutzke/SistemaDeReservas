class CreatePerfils < ActiveRecord::Migration[5.0]
  def change
    create_table :perfils do |t|
      t.string :name

      t.timestamps
    end
    add_index :perfils, :name, unique: true
  end
end
