class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.time :end_at, null: false
      t.time :start_at, null: false
      t.date :date_at, null: false
      t.integer :quantity, default: 1
      t.integer :state, default: 1
      t.boolean :reservation, default: true
      t.references :klass, foreign_key: true
      t.references :discipline, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
