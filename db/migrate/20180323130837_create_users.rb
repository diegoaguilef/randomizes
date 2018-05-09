class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :age
      t.date :birth_date

      t.timestamps
    end
  end
end
