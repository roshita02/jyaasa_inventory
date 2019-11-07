# frozen_string_literal: true

# Model for item transfer
class ItemTransfer < ApplicationRecord
  belongs_to :employee
  belongs_to :item
  belongs_to :item_assignment
  validates_presence_of :quantity
  has_many :item_return, dependent: :destroy
  scope :transferred, -> { where('quantity > 0') }
  after_save :send_mail, :update_quantity

  def send_mail
    @item_assignment = ItemAssignment.find(item_assignment_id)
    ItemTransferNotifierMailer.new_item_transfer(self, @item_assignment).deliver_now
    ItemTransferNotifierMailer.new_item_received(self, @item_assignment).deliver_now
  end

  def update_quantity
    @item_assignment = ItemAssignment.find(item_assignment_id)
    @borrowed_item = @item_assignment.item
    @borrowed_item.decrement!(:assigned_quantity, quantity.to_i)
    @borrowed_item.increment(:transferred_quantity, quantity.to_i)
    @borrowed_item.save!
    @item_assignment.decrement!(:quantity, quantity.to_i)
    @item_assignment.save!
  end
end
