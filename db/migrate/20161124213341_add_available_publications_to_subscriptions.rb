class AddAvailablePublicationsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :available_publications, :integer
  end
end
