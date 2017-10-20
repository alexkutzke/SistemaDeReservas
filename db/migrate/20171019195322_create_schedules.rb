class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.datetime :end_at, null: false
      t.datetime :start_at, null: false
      t.integer :quantity, default: 1
      t.integer :state, default: 1
      t.boolean :reservation, default: true
      t.references :klass, foreign_key: true
      t.references :discipline, foreign_key: true
      t.references :classroom, foreign_key: true
      t.references  :user, foreign_key: true
      t.timestamps
    end
  end
end
