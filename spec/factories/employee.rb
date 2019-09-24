# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name { 'roshita' }
    last_name { 'shakya' }
    designation { 'intern' }
    email { 'roshitashakya07@gmail.com' }
    password { 'roshita123' }
  end
end
