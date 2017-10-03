class DropKlasses < ActiveRecord::Migration[5.0]
  def change
    drop_table :klasses
  end
end
