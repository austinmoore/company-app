class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.references :company, foreign_key: true, null: false
      t.text :first_name, null: false
      t.text :last_name, null: false

      t.timestamps
    end
  end
end
