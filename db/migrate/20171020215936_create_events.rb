class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.boolean :reservation, default: true
      t.string :title, null: true
      t.integer :frequency, default: 1
      t.integer :state, default: 1
      t.references :klass, foreign_key: true
      t.references :discipline, foreign_key: true, null: true
      t.references :classroom, foreign_key: true, null: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
