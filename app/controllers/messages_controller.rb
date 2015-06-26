class MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.event_id = params[:id]
    @message.save!
    
    redirect_to messages_path(params[:id])
  end
  
  private
  
  def message_params
    params.require(:message).permit(:message)
  end
end
