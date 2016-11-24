class AddStripeFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_charge_id, :string
    add_column :subscriptions, :amount_paid, :decimal, precision: 15, scale: 2
  end
end
