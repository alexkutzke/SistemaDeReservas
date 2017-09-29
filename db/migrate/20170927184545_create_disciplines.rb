class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.string :discipline_code
      # set department_id to be null
      t.references :department, foreign_key: true, null: true

      t.timestamps
    end
  end
end