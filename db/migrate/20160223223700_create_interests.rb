class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.string :subcategory
      t.string :category

      t.timestamps null: false
    end
  end
end
