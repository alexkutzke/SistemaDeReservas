class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password, :limit => 20
      t.string :cpf, :limit => 11
      t.string :phone_number, :limit => 11
      t.references :role, foreign_key: true

      t.timestamps
    end
    add_index :users, :cpf, unique: true
    add_index :users, :email, unique: true
  end
end
