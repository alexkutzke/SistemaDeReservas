class CreatePeriods < ActiveRecord::Migration[5.0]
  def change
    create_table :periods do |t|
        t.integer :year
        t.integer :semester
        t.boolean :state
        t.date :start_date
        t.date :end_date

        t.timestamps
    end
  end
end
