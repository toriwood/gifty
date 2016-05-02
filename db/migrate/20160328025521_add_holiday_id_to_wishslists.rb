class AddHolidayIdToWishslists < ActiveRecord::Migration
  def change
    add_column :wishlists, :holiday_id, :integer
  end
end
