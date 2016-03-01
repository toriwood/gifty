class AddInterestToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :interest_id, :integer
  end
end
