class AddAdditionalInfoToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :additional_info, :text
  end
end
