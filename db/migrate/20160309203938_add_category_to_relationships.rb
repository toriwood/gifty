class AddCategoryToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :category, :string
  end
end
