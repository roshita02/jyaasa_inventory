FactoryBot.define do
  factory :vendor do
    name { "vendor1"}
    pan_no {12345678}

    trait :invalid do
      name { nil}
      pan_no {nil}
    end
  end
end