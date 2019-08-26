# frozen_string_literal: true

# Controller for Item Requests
class ItemRequestsController < InheritedResources::Base
  def new
    @item_request = ItemRequest.new
  end

  def create
    @item_request = ItemRequest.new(item_request_params)
    @email = current_employee.email
    if @item_request.save
      flash[:success] = 'Request made successfully'
    else
      render 'new'
    end
  end

  private

  def item_request_params
    params.require(:item_request).permit(:item, :quantity, :reason)
  end
end
