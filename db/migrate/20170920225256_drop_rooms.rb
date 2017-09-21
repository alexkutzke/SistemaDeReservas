class DropRooms < ActiveRecord::Migration[5.0]
  def change
    drop_table :rooms
  end
end
