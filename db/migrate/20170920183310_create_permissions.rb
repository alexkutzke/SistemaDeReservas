class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.references :perfil, foreign_key: true
      t.references :session, foreign_key: true
      t.references :action, foreign_key: true

      t.timestamps
    end
  end
end
