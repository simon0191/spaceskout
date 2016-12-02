class Dashboard::MessagesController < Dashboard::BaseController
  def index
    @conversations = current_user.mailbox.conversations.page(params[:page]).per(20)
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_read(current_user)
  end


  def reply
    @conversation = current_user.mailbox.conversations.find(params[:id])
    current_user.reply_to_conversation(@conversation, reply_params[:body])
    redirect_to dashboard_messages_path, notice: 'Message sent'
  end

  private

    def reply_params
      params.require(:reply).permit(:body)
    end
end