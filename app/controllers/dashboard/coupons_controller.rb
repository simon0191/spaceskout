class Dashboard::CouponsController < Dashboard::BaseController
  before_action :only_admins!
  before_action :set_coupon, only: [:edit, :update, :deactivate, :activate]

  def index
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to dashboard_coupons_path, notice: 'Coupon Created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to dashboard_coupons_path, notice: 'Coupon Updated'
    else
      render :edit
    end
  end

  def deactivate
    @coupon.update!(active: false)
    redirect_to dashboard_coupons_path, notice: 'Coupon Deactivated'
  end

  def activate
    @coupon.update!(active: true)
    redirect_to dashboard_coupons_path, notice: 'Coupon Activated'
  end

  private

    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:coupon_type, :discount, :code, :plan_id, :active)
    end

end