# frozen_string_literal: true

# Controller for Item
class ItemsController < InheritedResources::Base
  private

  def item_params
    params.require(:item).permit(:name, :type, :rate)
  end
end
