class PagesController < ApplicationController

  def home
  end

  def your_space_here
  end

  def our_story
  end

  def community_giveback
    @charity = Charity.featured.first
  end

  def terms_of_service
    render layout: false
  end
end