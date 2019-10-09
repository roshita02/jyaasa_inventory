# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id             :bigint           not null, primary key
#  name           :string
#  type           :string
#  rate           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  vendor_id      :bigint
#  quantity       :integer
#  category_id    :bigint
#  purchased_date :date
#
class Item < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  # belongs_to :vendor, optional: true
  validates_presence_of :name, :category_id
  belongs_to :category
  has_many :item_assignment, dependent: :destroy
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
      item = find_or_create_by(name: row['name'])
      item.attributes = values
      category = values['category_id']
      item.category_id = Category.find_by_name(category).id
      item.remaining_quantity = values['quantity']
      item.update({ name: row['name'], quantity: row['quantity'] })
      item.save!
    end
  end
end
