# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    name { 'roshita' }
    designation { 'intern' }
    email { 'roshitashakya07@gmail.com' }
    password { 'roshita123' }
    contact_no { '1234567' }
    address { 'Kathmandu' }
  end
end
