class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    space = Space.published.find(message_params[:space_id])
    recipient = space.owner
    current_user.send_message(recipient, message_params[:body], "#{current_user.full_name} wants to talk about the space #{space.name.capitalize}")
    redirect_to space_path(space.id), notice: 'Your message has been sent'
  end

  private

    def message_params
      params.require(:message).permit(:body, :space_id)
    end
end