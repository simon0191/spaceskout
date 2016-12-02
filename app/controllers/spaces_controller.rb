class SpacesController < ApplicationController
  def index
    @search_form = ::Spaces::SearchService.new(search_params)
    @spaces = @search_form.search(Space.published).order('rating DESC, created_at DESC').page(params[:page])
  end

  def show
    @space = Space.find(params[:id])
  end

  private

    def search_params
      params.permit(Spaces::SearchService.permitted_params)
    end
end