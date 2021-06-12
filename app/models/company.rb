class Company < ApplicationRecord
  has_many :sub_companies, class_name: "Company", foreign_key: "parent_company_id"

  has_many :employees

  belongs_to :parent_company, class_name: "Company", optional: true

  as_enum :area_of_practice, [:country, :region, :city], prefix: true, map: :string
end