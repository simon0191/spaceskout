# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  valid_through          :datetime
#  plan_id                :integer
#  coupon_id              :integer
#  user_id                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_charge_id       :string
#  amount_paid            :decimal(15, 2)
#  available_publications :integer
#

class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :coupon
  belongs_to :user
  has_many :spaces

  validates :valid_through, presence: true
  validates :user, presence: true
  validates :plan, presence: true

  scope :not_expired, -> { where('valid_through > ?', DateTime.now) }
  scope :with_available_posts, -> { where('available_publications > 0') }

  def self.calc_amount_to_pay(plan, coupon)
    case coupon.try(:coupon_type)
      when 'discount_percentage'
        plan.price * (1 - (coupon.discount/100.0))
      when 'discount_value'
        plan.price - coupon.discount
      else
        plan.price
    end
  end

  def self.calc_amount_to_pay_in_cents(plan, coupon)
    (calc_amount_to_pay(plan, coupon) * 100).floor
  end

  def amount_paid_in_cents
    (amount_paid * 100.0).floor
  end

  def not_expired?
    valid_through > DateTime.now
  end

  def donation_amount
    amount_paid * 0.1
  end

end
