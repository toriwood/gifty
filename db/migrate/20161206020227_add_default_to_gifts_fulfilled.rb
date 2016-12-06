class AddDefaultToGiftsFulfilled < ActiveRecord::Migration
  def change
    change_column_default :gifts, :fulfilled, false
  end
end
