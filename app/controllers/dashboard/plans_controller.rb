class Dashboard::PlansController < Dashboard::BaseController

  def index
    @plans = Plan.all
  end

  def validate_coupon
    plan = Plan.find(params[:id])
    @coupon_form = Plans::CouponForm.new(plan: plan, coupon_code: params[:coupon_code])

    if @coupon_form.valid?
      render :valid_coupon
    else
      render :invalid_coupon
    end
  end
end