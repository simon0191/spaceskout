# == Schema Information
#
# Table name: donations
#
#  id               :integer          not null, primary key
#  amount           :decimal(15, 2)   default(0.0)
#  charity_name     :string
#  stripe_charge_id :string
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  donor_email      :string
#

class Donation < ActiveRecord::Base
  belongs_to :user

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :charity_name, presence: true
  validates :stripe_charge_id, presence: true
  validates :donor_email, presence: true

  def amount_in_cents
    (amount * 100.0).floor
  end
end
