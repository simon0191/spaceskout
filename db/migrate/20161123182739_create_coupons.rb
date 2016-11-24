class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :coupon_type
      t.decimal :discount, default: 0.0, precision: 15, scale: 2
      t.string :code
      t.references :plan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
