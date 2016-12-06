class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.decimal :amount, precision: 15, scale: 2, default: 0.0
      t.string :charity_name
      t.string :stripe_charge_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
