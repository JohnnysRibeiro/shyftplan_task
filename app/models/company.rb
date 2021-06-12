# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :parent_company, class_name: 'Company', optional: true
  has_many :sub_companies, class_name: 'Company', foreign_key: 'parent_company_id', inverse_of: :parent_company
  has_many :employees

  as_enum :area_of_practice, %i[country region city], prefix: true, map: :string
end
