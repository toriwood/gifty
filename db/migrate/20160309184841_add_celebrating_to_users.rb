class AddCelebratingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :celebrating, :text
  end
end
