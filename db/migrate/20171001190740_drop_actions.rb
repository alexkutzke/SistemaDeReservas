class DropActions < ActiveRecord::Migration[5.0]
  def change
    drop_table :actions
  end
end
