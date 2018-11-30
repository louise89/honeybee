class AddAdminColumnToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: 0, null: false
  end
end