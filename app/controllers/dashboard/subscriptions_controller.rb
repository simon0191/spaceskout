class Dashboard::SubscriptionsController < Dashboard::BaseController

  def new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    form = Subscriptions::ChargeAndCreateForm.new(
      user: current_user,
      plan: Plan.find(params[:plan_id]),
      coupon: Coupon.find_by_code(params[:coupon_code]),
      stripe_token: params[:stripe_token]
    )
    if form.valid? && form.save!
      render json: {status: 'success'}, status: :created
    else
      render json: {status: 'error', errors: form.errors}, status: :unprocessable_entity
    end
  end

  private

    def create_subscription_params
      params.permit(:stripe_token, :plan_id, :coupon_code)
    end

end