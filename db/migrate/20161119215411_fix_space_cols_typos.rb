class FixSpaceColsTypos < ActiveRecord::Migration
  def change
    rename_column :spaces, :weekdays_avaiability_from, :weekdays_availability_from
    rename_column :spaces, :weekdays_avaiability_to, :weekdays_availability_to
    rename_column :spaces, :weekend_avaiability_from, :weekend_availability_from
    rename_column :spaces, :weekend_avaiability_to, :weekend_availability_to
    rename_column :spaces, :price_hour, :price_hourly
    rename_column :spaces, :space_description, :description
  end
end
