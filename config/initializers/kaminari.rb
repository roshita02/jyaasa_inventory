# frozen_string_literal: true

# Kaminari.configure do |config|
#   config.page_method_name = :per_page_kaminari
#   if defined?(WillPaginate)
#   module WillPaginate
#     module ActiveRecord
#       module RelationMethods
#         def per(value = nil) per_page(value) end
#         def total_count() count end
#       end
#     end
#     module CollectionMethods
#       alias_method :num_pages, :total_pages
#     end
#   end
#   end
# end

# if defined?(WillPaginate)
#   module WillPaginate
#     module ActiveRecord
#       module RelationMethods
#         alias_method :per, :per_page
#         alias_method :num_pages, :total_pages
#         alias_method :total_count, :count
#       end
#     end
#   end
# end
