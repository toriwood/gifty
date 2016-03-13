class AddColumnsToWishlists < ActiveRecord::Migration
  def change
    add_column :wishlists, :interest, :string, default: "random"
    add_column :wishlists, :special_day, :string, default: "none"
  end
end
