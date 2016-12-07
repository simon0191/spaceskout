class AddDonorEmailToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :donor_email, :string
  end
end
