class Customers::RegistrationsController < Devise::RegistrationsController

  private

    def sign_up_params
      params.require(:customer).permit(
        :first_name, :last_name, :email, :password
      ).merge(password_confirmation: params[:customer][:password])
    end

    def account_update_params
      params.require(:customer).permit(
        :first_name, :last_name, :password, :password_confirmation
      )
    end
end
