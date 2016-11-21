class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.boolean :featured, default: false

      t.timestamps null: false
    end
  end
end
