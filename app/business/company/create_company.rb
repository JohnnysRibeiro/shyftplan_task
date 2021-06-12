class Company::CreateCompany < ApplicationBusiness
  def initialize(params)
    @params = params
  end

  def call
    company = Company.new(@params)
    check_hierarchy(company) if company.parent_company.present?
    company.save!

    company
  rescue StandardError => e
    e
  end

  private

  def check_hierarchy(company)
    acceptable_hierarchies = {
      :country => [:region, :city],
      :region => [:city]
    }
    unless acceptable_hierarchies[company.parent_company.area_of_practice].include? company.area_of_practice
      raise StandardError.new "Incorrect Company Hierarchy. Please check parent company."
    end
  end
end