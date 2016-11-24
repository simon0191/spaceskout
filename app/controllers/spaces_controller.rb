class SpacesController < ApplicationController
  def index
    @search_form = ::Spaces::SearchService.new(search_params)
    @spaces = @search_form.search(Space.published).page(params[:page])
  end

  def show
    @space = Space.find(params[:id])
  end

  private

    def search_params
      params.permit(Spaces::SearchService.permitted_params)
    end
end