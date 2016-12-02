class RenamePhoneColumnsInSpace < ActiveRecord::Migration
  def change
    rename_column :spaces, :phone, :phone_temp
    rename_column :spaces, :phone_number, :phone
    rename_column :spaces, :phone_temp, :phone_number
  end
end
