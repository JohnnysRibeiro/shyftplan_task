FactoryBot.define do
  factory :company do
    area_of_practice_cd { "country" }
    required_employees_amount { 14 }
  end
end