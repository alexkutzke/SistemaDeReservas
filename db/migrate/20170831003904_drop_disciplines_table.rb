class DropDisciplinesTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :disciplines
  end
end
