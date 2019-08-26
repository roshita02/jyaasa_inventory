# frozen_string_literal: true

# Conntroller for items
class ItemsController < InheritedResources::Base
  private

  def item_params
    params.require(:item).permit(:name, :type, :rate)
  end
end
