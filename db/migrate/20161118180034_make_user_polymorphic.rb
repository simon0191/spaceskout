class MakeUserPolymorphic < ActiveRecord::Migration
  def change
    remove_column :users, :role, :integer
    add_column :users, :type, :string
  end
end
