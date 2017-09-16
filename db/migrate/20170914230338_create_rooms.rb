class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :capacity
      t.string :room, unique: true
      t.string :building
      t.boolean :state
      t.string :description
      t.string :responsible_person
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
