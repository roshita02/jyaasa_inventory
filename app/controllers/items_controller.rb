# frozen_string_literal: true

# Controller for items
class ItemsController < InheritedResources::Base
  before_action :authenticate_employee!

  def index
    @items = ItemAssignment.all.where(current_employee.id == :employee_id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :type, :rate)
  end
end
