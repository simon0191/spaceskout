class Dashboard::CharitiesController < Dashboard::BaseController
  before_action :only_admins!
  before_action :set_charity

  def edit
  end

  def update
    if @charity.update(charity_params)
      redirect_to edit_dashboard_charity_path, notice: 'Charity Updated'
    else
      render :edit
    end
  end

  private

    def set_charity
      @charity = Charity.first
    end

    def charity_params
      params.require(:charity).permit(:name, :description, :logo)
    end

end