class SpaceOwners::RegistrationsController < Devise::RegistrationsController

  def current_space_owner
    current_user if user_signed_in? && current_user.type == 'SpaceOwner'
  end

  protected
    def authenticate_scope!
      authenticate_user!(force: true)
      self.resource = current_user
    end

  private

    def sign_up_params
      params.require(:space_owner).permit(
        :business_name, :first_name, :last_name, :email, :phone, :password, :password_confirmation, :avatar, :avatar_cache
      ).merge(password_confirmation: params[:space_owner][:password])
    end

    def account_update_params
      params.require(:space_owner).permit(
        :business_name, :first_name, :last_name, :phone, :current_password, :password, :password_confirmation, :avatar, :avatar_cache
      )
    end
end
