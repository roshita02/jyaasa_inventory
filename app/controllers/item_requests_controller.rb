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
    @item_request.employee = current_employee
    if @item_request.save
      ItemRequestNotifierMailer.new_item_request(@item_request, @item_request.employee).deliver_later(wait: 1.second)
      sleep 1
      redirect_to employee_dashboard_index_path, flash: { success: 'Item Request successful' }
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
