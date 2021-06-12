# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    area_of_practice_cd { 'country' }
    required_employees_amount { 5 }
  end
end
