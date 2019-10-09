# frozen_string_literal: true

# Model for item assignment
class ItemAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :category
  belongs_to :item
  validates_presence_of :quantity, :employee_id, :category_id, :item_id
  enum status: { assigned: 1, returned: 0, transferred: 2 }
  scope :returned, -> { where(status: 'returned') }
  scope :assigned, -> { where(status: 'assigned') }
  scope :transferred, -> { where(status: 'transferred') }
  after_save :remaining_quantity

  def remaining_quantity
    item.remaining_quantity = item.remaining_quantity - quantity
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
      item_assignment = find_by_id(row['id']) || new
      item_assignment.attributes = values
      employee = values['employee_id']
      item_assignment.employee_id = Employee.find_by_name(employee).id
      category = values['category_id']
      item_assignment.category_id = Category.find_by_name(category).id
      item = values['item_id']
      item_assignment.item_id = FixedItem.find_by_name(item).id
      item_assignment.save!
      if item_assignment.save
        @item = Item.find(item_assignment.item_id)
        @item.increment!(:assigned_quantity, values['quantity'])
        @item.save
      end
    end
  end
end
