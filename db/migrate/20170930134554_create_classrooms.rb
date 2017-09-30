class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.integer :capacity
      t.string :room
      t.string :building
      t.boolean :state
      t.string :description
      t.string :responsible_person
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :classrooms, :room, unique: true
  end
end
