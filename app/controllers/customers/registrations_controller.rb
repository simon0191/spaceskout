class Customers::RegistrationsController < Devise::RegistrationsController

  def current_customer
    current_user if user_signed_in? && current_user.type == 'Customer'
  end

  protected
    def authenticate_scope!
      authenticate_user!(force: true)
      self.resource = current_user
    end

  private

    def sign_up_params
      params.require(:customer).permit(
        :first_name, :last_name, :email, :password
      ).merge(password_confirmation: params[:customer][:password])
    end

    def account_update_params
      params.require(:customer).permit(
        :first_name, :last_name, :current_password, :password, :password_confirmation, :avatar, :avatar_cache
      )
    end
end
