class AddInterestIdColumnToWishlists < ActiveRecord::Migration
  def change
    add_column :wishlists, :interest_id, :integer, default: 0
  end
end
