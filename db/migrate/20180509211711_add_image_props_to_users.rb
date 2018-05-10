class AddImagePropsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cl_image_props, :jsonb
  end
end
