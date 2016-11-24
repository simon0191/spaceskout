class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :number_of_publications
      t.decimal :price, default: 0.0, precision: 15, scale: 2
      t.integer :duration_in_days, default: 0

      t.timestamps null: false
    end
  end
end
