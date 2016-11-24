class Subscriptions::ChargeAndCreateForm < BaseForm

  attr_accessor :user, :plan, :coupon, :stripe_token

  validates :plan, presence: true
  validates :stripe_token, presence: true

  validate :validate_coupon_and_plan

  def save!
    subscription = user.subscriptions.build(
      plan: plan,
      coupon: coupon,
      amount_paid: Subscription.calc_amount_to_pay(plan, coupon),
      valid_through: DateTime.now + plan.duration_in_days.days,
      available_publications: plan.number_of_publications
    )

    response = Stripe::Charge.create(
      amount: subscription.amount_paid_in_cents,
      currency: "usd",
      source: stripe_token,
      description: "Subscription to SpaceSkout #{plan.name.capitalize} plan"
    )
    if response.status == 'succeeded'
      subscription.stripe_charge_id = response.id
      subscription.save!
      true
    else
      errors[:charge] << "wasn't successful"
      errors[:charge] << response.failure_message
      false
    end
  end

  private

    def validate_coupon_and_plan
      if plan && coupon && !coupon.valid_for_plan?(plan)
        errors[:coupon] << "invalid for #{plan.name} plan"
      end
    end

end