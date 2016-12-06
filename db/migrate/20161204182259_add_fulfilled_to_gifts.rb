class AddFulfilledToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :fulfilled, :boolean
  end
end
