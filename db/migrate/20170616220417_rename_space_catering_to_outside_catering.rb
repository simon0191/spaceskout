class RenameSpaceCateringToOutsideCatering < ActiveRecord::Migration
  def change
    rename_column :spaces, :catering, :outside_catering_allowed
  end
end
