class Company < ApplicationRecord
  has_many :child_companies, class_name: "Company", foreign_key: "parent_company_id"

  has_many :employees

  belongs_to :parent_company, class_name: "Company", optional: true
end