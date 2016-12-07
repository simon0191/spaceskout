class Dashboard::SubscriptionsController < Dashboard::BaseController
  before_action :only_space_owners!
  def new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    form = Subscriptions::ChargeAndCreateForm.new(
      user: current_user,
      plan: Plan.find(params[:plan_id]),
      coupon: Coupon.active.find_by_code(params[:coupon_code]),
      stripe_token: params[:stripe_token]
    )
    if form.valid? && form.save!
      flash[:notice] = 'Subscription created'
      render json: {status: 'success'}, status: :created
    else
      render json: {status: 'error', errors: form.errors}, status: :unprocessable_entity
    end
  end

end