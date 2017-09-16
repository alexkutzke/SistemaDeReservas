class DropPeriods < ActiveRecord::Migration[5.0]
  def change
    drop_table :periods
  end
end
