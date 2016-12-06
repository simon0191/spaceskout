class Plans::CouponForm < BaseForm
  attr_accessor :plan, :coupon_code

  validates :coupon_code, presence: true
  validate :validate_coupon_code

  private

    def validate_coupon_code
      if coupon_code.present?
        coupon = Coupon.active.find_by_code(coupon_code)
        if coupon.nil?
          errors[:coupon_code] << 'not found'
        elsif !coupon.valid_for_plan?(plan)
          errors[:coupon_code] << "invalid for #{plan.name} plan"
        end
      end
    end
end