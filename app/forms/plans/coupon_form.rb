class Plans::CouponForm < BaseForm
  attr_accessor :plan, :coupon_code

  validates :coupon_code, presence: true
  validate :validate_coupon_code

  def price_with_discount_in_cents
    @price_with_discount_in_cents ||= Subscription.calc_amount_to_pay_in_cents(plan, coupon)
  end

  private

    def coupon
      @coupon ||= if coupon_code.present?
        Coupon.active.find_by_code(coupon_code)
      end
    end

    def validate_coupon_code
      if coupon.nil?
        errors[:coupon_code] << 'not found'
      elsif !coupon.valid_for_plan?(plan)
        errors[:coupon_code] << "invalid for #{plan.name} plan"
      end
    end
end