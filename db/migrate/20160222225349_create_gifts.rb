class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :wishlist_id
      t.string :url
      t.text :description

      t.timestamps null: false
    end
  end
end
