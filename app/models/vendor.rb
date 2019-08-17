# frozen_string_literal: true

class Vendor < ApplicationRecord
  validates_presence_of :name 
end