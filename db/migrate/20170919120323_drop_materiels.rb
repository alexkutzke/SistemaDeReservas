class DropMateriels < ActiveRecord::Migration[5.0]
  def change
    drop_table :materiels
  end
end
