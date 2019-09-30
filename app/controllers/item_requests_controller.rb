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
      redirect_to employee_dashboard_index_path
    else
      render 'new'
    end
  end

  def index
    @item_requests = current_employee.item_request.paginate(page: params[:page], per_page: 10)
  end

  private

  def item_request_params
    params.require(:item_request).permit(:item, :quantity, :reason)
  end
end
