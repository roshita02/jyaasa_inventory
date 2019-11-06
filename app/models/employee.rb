# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint
#  invitations_count      :integer          default(0)
#  designation            :string
#  name                   :string
#  contact_no             :string
#  address                :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  unconfirmed_email      :string
#  confirmation_sent_at   :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#
class Employee < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable, :validate_on_invite => true
  has_many :item_request
  has_many :item_assignment, dependent: :destroy
  has_many :item_transfer, dependent: :destroy
  has_many :items, through: :item_assignment
  has_many :items, through: :item_transfer
  has_many :user_comment, dependent: :destroy
  scope :not_invited, -> { where(invitation_sent_at: [nil]) }
  scope :invitation_accepted, -> { where.not(invitation_accepted_at: [nil]) }
  validates_presence_of :name, :designation
  validates_length_of :contact_no, minimum: 7, maximum: 10, allow_blank: true

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
      employee = find_or_initialize_by(email: row['email'])
      employee.attributes = row.to_hash
      employee.skip_confirmation!
      employee.update(name: row['name'], email: row['email'])
      send_invitation(employee)
    end
  end

  def self.send_invitation(employee)
    Employee.invite!(email: employee.email, name: employee.name, designation: employee.designation, contact_no: employee.contact_no, address: employee.address) do |u|
      u.skip_invitation = true
    end
  end

  protected

  def password_required?
    confirmed? ? super : false
  end
end
