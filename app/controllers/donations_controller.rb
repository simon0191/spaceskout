class DonationsController < ApplicationController

  def create
    form = Donations::ChargeAndCreateForm.new(
      user: current_user,
      amount: params[:amount],
      charity_name: Charity.featured.first.name,
      stripe_token: params[:stripe_token]
    )
    if form.valid? && form.save!
      flash.now[:notice] = 'Thanks for your donation!'
      render json: {status: 'success'}, status: :created
    else
      render json: {status: 'error', errors: form.errors}, status: :unprocessable_entity
    end
  end

end