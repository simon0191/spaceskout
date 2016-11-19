class Dashboard::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :only_space_owners!

  private

    def only_space_owners!
      unless current_user.has_access_level?(:space_owner)
        redirect_to root_path, error: 'Access not allowed'
      end
    end
end