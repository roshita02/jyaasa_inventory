# frozen_string_literal: true

module ActiveAdmin
  module Views
    class Footer < Component
      def build(_namespace)
        super id: 'footer'
        super style: 'text-align: center;'

        div do
          small "Copyright #{Date.today.year} Jyaasa Inventory"
        end
      end
    end
  end
end
