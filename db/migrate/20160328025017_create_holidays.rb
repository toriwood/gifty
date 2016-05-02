class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :user_id
      t.string :name
      t.datetime :date
      t.boolean :recurring?

      t.timestamps null: false
    end
  end
end
