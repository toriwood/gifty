class RemoveInterestColumnFromWishlists < ActiveRecord::Migration
  def change
    remove_column :wishlists, :interest, :string
  end
end
