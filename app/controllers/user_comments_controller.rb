# frozen_string_literal: true

# Controller for user comments
class UserCommentsController < ApplicationController
  def new
    @user_comment = UserComment.new
    @user_comment.employee_id = current_employee.id
  end

  def create
    @request = ItemRequest.find(params[:user_comment][:item_request_id])
    @user_comment = @request.user_comment.new(user_comment_params)
    @user_comment.employee_id = current_employee.id
    if @user_comment.save
      redirect_to item_request_path(@request), flash: { success: 'Comment successfully added' }
    else
      redirect_to item_request_path(@request)
    end
  end

  def destroy
    @request = ItemRequest.find(params[:item_request_id])
    @user_comment = @request.user_comment.find(params[:id])
    @user_comment.destroy
    redirect_to item_request_path(@request), flash: { success: 'Comment successfully deleted' }
  end

  private

  def user_comment_params
    params.require(:user_comment).permit(:body, :item_request_id)
  end
end
