class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.string :discipline_code
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end