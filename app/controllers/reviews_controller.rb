class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space

  def new
    respond_to do |format|
      format.html { redirect_to space_path(@space) }
      format.js   { render :new }
    end
  end

  def create
    @review = @space.reviews.build(review_params.merge(user: current_user))
    if @review.save
      render :create_succeed
    else
      render :create_failed
    end
  end

  private

    def set_space
      @space = Space.published.find(params[:space_id])
    end

    def review_params
      params.require(:review).permit(:rating, :text)
    end
end