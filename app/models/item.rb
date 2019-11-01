# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  type                 :string
#  rate                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  vendor_id            :bigint
#  quantity             :integer
#  purchased_date       :date
#  assigned_quantity    :integer
#  category_id          :bigint
#  withdrawn_quantity   :integer
#  available_quantity   :integer
#  remaining_quantity   :integer
#  status               :integer          default("out of stock")
#  transferred_quantity :integer
#
class Item < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  # belongs_to :vendor, optional: true
  validates_presence_of :name, :category_id
  belongs_to :category
  has_many :item_assignment, dependent: :destroy
  has_many :item_transfer, dependent: :destroy
  has_many :purchase, dependent: :destroy
  has_many :withdraw, dependent: :destroy
  enum status: { 'out of stock': 0, 'in stock': 1, 'low stock': 2 }

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
      item = find_or_initialize_by(name: row['name'])
      category = values['category']
      item_name = values['name']
      vendor_name = values['vendor']

      if Item.find_by_name(item_name).nil?
        item.category_id = Category.find_by_name(category).id
        item.name = item_name
        item.quantity = item.quantity_was.to_i + values['quantity'].to_i
        item.remaining_quantity = item.remaining_quantity_was.to_i + values['quantity'].to_i
        item.save!
      end

      next if row['purchased_quantity'].nil?

      purchase = Purchase.new
      purchase.quantity = row['purchased_quantity']
      purchase.category_id = Category.find_by_name(category).id
      purchase.item_id = Item.find_by_name(item_name).id

      unless vendor_name.nil?
        if Vendor.find_by_name(vendor_name).nil?
          vendor = Vendor.create(name: row['vendor'], pan_no: row['pan_no'])
          vendor.save!
        end
        purchase.vendor_id = Vendor.find_by_name(vendor_name).id
      end
      purchase.purchased_date = row['purchased_date']
      purchase.rate = row['rate']
      purchase.type = "#{item.type}Purchase"
      purchase.save!
    end
  end
end
