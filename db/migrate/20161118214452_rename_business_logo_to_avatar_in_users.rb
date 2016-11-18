class RenameBusinessLogoToAvatarInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :business_logo, :avatar
  end
end
