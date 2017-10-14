class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
        t.boolean :index, default: false
        t.boolean :new, default: false
        t.boolean :edit, default: false
        t.boolean :remove, default: false
        t.boolean :import, default: false
        t.integer :session, default: false
        t.references :role, foreign_key: true, null: false
        t.timestamps
    end
  end
end
