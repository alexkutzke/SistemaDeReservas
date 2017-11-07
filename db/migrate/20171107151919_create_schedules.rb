class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.datetime :end, null: false
      t.datetime :start, null: false
      t.integer :frequency, default: 1
      t.string :color, default: "#c3302c"
      t.integer :state, default: 1
      t.boolean :reservation, default: true
      t.string :title, null: true
      t.references :klass, foreign_key: true, null: true
      t.references :discipline, foreign_key: true, null: true
      t.references :classroom, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
