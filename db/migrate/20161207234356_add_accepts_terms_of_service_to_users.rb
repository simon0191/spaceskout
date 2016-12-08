class AddAcceptsTermsOfServiceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accepts_terms_of_service, :boolean
  end
end
