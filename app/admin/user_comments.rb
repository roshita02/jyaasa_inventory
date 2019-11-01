# frozen_string_literal: true

ActiveAdmin.register UserComment do
  menu false
  controller do
    def new
      @user_comment = UserComment.new
    end

    def create
      @request = ItemRequest.find(params[:user_comment][:item_request_id])
      @user_comment = @request.user_comment.new(user_comment_params)
      @user_comment.admin_user_id = current_admin_user.id
      if @user_comment.save
        CommentNotifierMailer.new_comment(@user_comment, @request).deliver_now
        redirect_to admin_item_request_path(@request), flash: { success: 'Comment successfully added' }
      else
        redirect_to admin_item_request_path(@request), flash: { danger: 'Comment is invalid' }
      end
    end

    def destroy
      @request = ItemRequest.find(params[:item_request_id])
      @user_comment = @request.user_comment.find(params[:id])
      @user_comment.destroy
      redirect_to admin_item_request_path(@request)
    end

    private

    def user_comment_params
      params.require(:user_comment).permit(:body, :item_request_id)
    end
  end
end
