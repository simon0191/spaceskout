class Donations::ChargeAndCreateForm < BaseForm

  attr_accessor :user, :amount, :charity_name, :stripe_token, :donor_email

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :charity_name, presence: true
  validates :stripe_token, presence: true
  validates :donor_email, presence: true

  def save!
    donation = Donation.new(
      user: user,
      amount: amount,
      charity_name: charity_name,
      donor_email: donor_email
    )
    response = Stripe::Charge.create(
      amount: donation.amount_in_cents,
      currency: "usd",
      source: stripe_token,
      description: "Donation to charity_name"
    )
    if response.status == 'succeeded'
      donation.stripe_charge_id = response.id
      donation.save!
      DonationsMailer.thank_you(donation).deliver_later
      true
    else
      errors[:charge] << "wasn't successful"
      errors[:charge] << response.failure_message
      false
    end
  end

end