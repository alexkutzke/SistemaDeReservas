class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :capacity
      t.string :place
      t.string :block
      t.string :category
      t.boolean :state

      t.timestamps
    end
  end
end
