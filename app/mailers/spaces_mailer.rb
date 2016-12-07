class SpacesMailer < ApplicationMailer
  def space_published(space)
    @space = space
    @user = @space.owner
    mail to: @user.email, subject: 'Congrats - your Space has been published!'
  end
end
