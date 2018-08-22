class AddUrlAttributeDishesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :img_url, :text
  end
end
