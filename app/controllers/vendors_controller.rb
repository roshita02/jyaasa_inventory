# frozen_string_literal: true

# Controller for vendor
class VendorsController < InheritedResources::Base
  private

  def vendor_params
    params.require(:vendor).permit(:name, :pan_no)
  end
end
