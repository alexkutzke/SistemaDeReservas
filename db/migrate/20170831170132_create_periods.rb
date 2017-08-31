class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
      t.integer :semester
      t.boolean :state
      t.date :start_date
      t.date :end_date
      t.integer :course

      t.timestamps
    end
  end
end
