# frozen_string_literal: true

# Model for purchase table
class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :vendor, optional: true
  belongs_to :category
  validates_presence_of :quantity, :category_id, :item_id

  after_save :increase_quantity
  after_destroy :decrease_quantity
  before_update :get_old_quantity
  after_update :update_quantity

  def increase_quantity
    incr_quantity = quantity
    item.increment(:quantity, incr_quantity)
    item.increment(:remaining_quantity, incr_quantity)
    item.save
  end

  def decrease_quantity
    dec_quantity = quantity
    item.decrement!(:quantity, dec_quantity)
    item.decrement!(:remaining_quantity, dec_quantity)
    item.save
  end

  def get_old_quantity
    @old_quantity = quantity_was
  end

  def update_quantity
    updated_quantity = quantity
    item = self.item
    item.quantity = (item.quantity - @old_quantity) + updated_quantity
    item.remaining_quantity = (item.remaining_quantity.to_i - @old_quantity) + updated_quantity
    item.save
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path, csv_options: { encoding: 'iso-8859-1:utf-8' }, file_warning: :ignore)
    when '.xls' then Roo::Excel.new(file.path, file_warning: :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, file_warning: :ignore)
    else 
      raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(3)
    (4..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      values = row.to_hash
      purchase = find_by_id(row['id']) || new
      purchase.attributes = values
      category = values['category_id']
      purchase.category_id = Category.find_by_name(category).id
      item = values['item_id']
      purchase.item_id = Item.find_by_name(item).id
      vendor = values['vendor_id']
      purchase.vendor_id = Vendor.find_by_name(vendor).id
      purchase.save!
    end
  end
end
