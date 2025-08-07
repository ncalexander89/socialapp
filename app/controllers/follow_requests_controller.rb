class FollowRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @follow_request = current_user.sent_follow_requests.build(receiver_id: params[:receiver_id], status: "pending")
    if @follow_request.save
      redirect_to users_path, notice: "Follow request sent!"
    else
      redirect_to users_path, alert: @follow_request.errors.full_messages.to_sentence
    end
  end

  def update
    @follow_request = current_user.received_follow_requests.find(params[:id])
    if @follow_request.update(status: params[:status])
      redirect_to follow_requests_path, notice: "Follow request #{params[:status]}!"
    else
      redirect_to follow_requests_path, alert: "Unable to update request."
    end
  end
end

private

def follow_request_params
  params.require(:follow_request).permit(:status)
end