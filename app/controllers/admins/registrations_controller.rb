class Admins::RegistrationsController < Devise::RegistrationsController

  def new
    flash[:error] = 'Action not permited'
    redirect_to root_path
  end

  def create
    flash[:error] = 'Action not permited'
    redirect_to root_path
  end


  def current_admin
    current_user if user_signed_in? && current_user.type == 'Admin'
  end

  protected
    def authenticate_scope!
      authenticate_user!(force: true)
      self.resource = current_user
    end

  private

    def account_update_params
      params.require(:admin).permit(
        :first_name, :last_name, :current_password, :password, :password_confirmation, :avatar, :avatar_cache, :phone
      )
    end
end
