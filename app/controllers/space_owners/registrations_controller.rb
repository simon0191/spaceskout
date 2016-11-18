class SpaceOwners::RegistrationsController < Devise::RegistrationsController

  private

    def sign_up_params
      params.require(:space_owner).permit(
        :business_name, :first_name, :last_name, :email, :phone, :password, :password_confirmation, :avatar, :avatar_cache
      ).merge(password_confirmation: params[:space_owner][:password])
    end

    def account_update_params
      params.require(:space_owner).permit(
        :business_name, :first_name, :last_name, :phone, :password, :password_confirmation, :avatar, :avatar_cache
      )
    end
end
