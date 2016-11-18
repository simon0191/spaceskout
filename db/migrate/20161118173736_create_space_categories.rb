class CreateSpaceCategories < ActiveRecord::Migration
  def change
    create_table :space_categories do |t|
      t.references :category, index: true, foreign_key: true
      t.references :space, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
