# frozen_string_literal: true

# Helper method
module ApplicationHelper
  def status_color(status)
    if status == 'pending'
      'yellow'
    elsif status == 'approved'
      'green'
    else
      'red'
    end
  end
end
