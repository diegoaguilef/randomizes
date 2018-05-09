class AddUserToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string, index: { unique: true }
  end
end
