class AddPhoneToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :cell_phone, :string
  end
end
