class Dashboard::PlansController < Dashboard::BaseController
  before_action :only_space_owners!
  before_action :only_admins!, only: [:edit, :update]

  def index
    @plans = Plan.all.order(:order)
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to dashboard_plans_path, notice: 'Plan updated'
    else
      render :edit
    end
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

  private

    def plan_params
      params.require(:plan).permit(:name, :number_of_publications, :price, :order)
    end
end