class AddInhouseCateringToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :inhouse_catering, :boolean, default: false
  end
end
