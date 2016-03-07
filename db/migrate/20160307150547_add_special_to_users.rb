class AddSpecialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :special_days, :text
  end
end
