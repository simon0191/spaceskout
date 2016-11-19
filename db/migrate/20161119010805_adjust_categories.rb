class AdjustCategories < ActiveRecord::Migration
  def change
    add_column :categories, :active, :boolean, default: false
    add_column :categories, :description, :string
  end
end
