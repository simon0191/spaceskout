class SpacesController < ApplicationController
  def index
    @search_service = ::Spaces::SearchService.new(search_params)
    @spaces = @search_service.search(Space.all).page(params[:page])
  end

  private

    def search_params
      params.permit(Spaces::SearchService.permitted_params)
    end
end