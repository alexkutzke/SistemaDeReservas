class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.boolean :view
      t.boolean :register
      t.boolean :edit
      t.boolean :remove
      t.references :perfil, foreign_key: true
      t.references :session, foreign_key: true

      t.timestamps
    end
  end
end
