# frozen_string_literal: true

# Controller for item requests
class ItemRequestsController < InheritedResources::Base
  before_action :authenticate_employee!
  def new
    @item_request = ItemRequest.new
    @item_request.employee = current_employee
  end

  def create
    @item_request = ItemRequest.new(item_request_params)
    @email = current_employee.email
    @item_request.employee = current_employee
    if @item_request.save
      flash[:success] = 'Request made successfully'
    else
      render 'new'
    end
  end

  def index
    @item_requests = current_employee.item_request
  end

  private

  def item_request_params
    params.require(:item_request).permit(:item, :quantity, :reason)
  end
end
