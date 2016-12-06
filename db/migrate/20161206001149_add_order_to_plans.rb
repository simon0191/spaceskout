class AddOrderToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :order, :integer
  end
end
