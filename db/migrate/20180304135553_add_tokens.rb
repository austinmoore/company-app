class AddTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :identity, :text, null: false
    add_index :companies, :identity, unique: true

    add_column :employees, :identifier, :text, null: false
    add_index :employees, :identifier, unique: true
  end
end
