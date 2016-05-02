class AddHolidayIdToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :holiday_id, :integer
  end
end
