class AddRoleAndThemeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :theme, :integer, default: 0, null: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    add_index :users, :role
  end
end
