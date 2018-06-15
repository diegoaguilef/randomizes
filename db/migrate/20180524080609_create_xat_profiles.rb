class CreateXatProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :xat_profiles do |t|
      t.string :name
      t.string :nick
      t.integer :age
      t.integer :xat_id
      t.string :photos

      t.timestamps
    end
    add_index :xat_profiles, :xat_id, unique: true
  end
end
