class AdjustUser < ActiveRecord::Migration
  def change
    add_column :users, :business_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :business_logo, :string
  end
end
