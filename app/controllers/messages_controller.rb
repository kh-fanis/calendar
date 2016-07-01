class MessagesController < ApplicationController
  before_filter :authorizate_user!
  def index
    @messages = Message.where('sender_id = ? OR reciver_id = ?', current_user, current_user).order('created_at DESC')
    render :index
    current_user.update_attribute :last_seen_messages, Time.now
  end

  def new
    @message = Message.new
  end

  def create
    Message.create(message_params)
    redirect_to messages_path, notice: 'Message has successfully sent!'
  end

  def destroy
    @message = Message.find(params[:id])
    @message.update_attribute :deleted_by_sender,  true if @message.sender  == current_user
    @message.update_attribute :deleted_by_reciver, true if @message.reciver == current_user
    redirect_to :back
  end

private

  def message_params
    params.require(:message).permit(:content, :reciver_id).merge(sender_id: current_user.id)
  end

  def authorizate_user!
    redirect_to new_user_session_path, notice: 'First of all you need to sign in' unless user_signed_in?
  end
end
