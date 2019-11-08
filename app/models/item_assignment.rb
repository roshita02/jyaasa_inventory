# frozen_string_literal: true

# == Schema Information
#
# Table name: item_assignments
#
#  id                   :bigint           not null, primary key
#  quantity             :integer
#  employee_id          :bigint           not null
#  item_id              :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default("assigned")
#  returned_date        :date
#  category_id          :bigint
#  assigned_date        :date
#  transferred_quantity :integer
#  returned_quantity    :integer
#  transferred_date     :date
#

# Model for item assignment
class ItemAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :category
  belongs_to :item
  has_many :item_transfer, dependent: :destroy
  has_many :item_return, dependent: :destroy
  validates_presence_of :quantity, :employee_id, :category_id, :item_id
  enum status: { assigned: 1 }
  scope :assigned, -> { where('quantity > 0') }
  after_save :remaining_quantity

  def remaining_quantity
    @item = Item.find(item_id)
    remaining_qty = @item.quantity - (quantity + @item.transferred_quantity.to_i)
    @item.remaining_quantity = remaining_qty
    @item.save
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
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      values = row.to_hash
      item_assignment = find_by_id(row['id']) || new
      # item_assignment.attributes = values
      employee = values['employee']
      item_assignment.employee_id = Employee.find_by_name(employee).id
      category = values['category']
      item_assignment.category_id = Category.find_by_name(category).id
      item = values['item']
      item_assignment.item_id = FixedItem.find_by_name(item).id
      item_assignment.quantity = values['quantity']
      item_assignment.assigned_date = values['assigned_date']
      item_assignment.save!
      if item_assignment.save
        @assigned_item = FixedItem.find(item_assignment.item_id)
        @assigned_item.increment!(:assigned_quantity, values['quantity'])
        @assigned_item.save!
      end
    end
  end
end
