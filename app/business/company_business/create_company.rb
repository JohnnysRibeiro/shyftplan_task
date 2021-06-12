# frozen_string_literal: true

module CompanyBusiness
  class CreateCompany
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
        country: %i[region city],
        region: [:city]
      }
      return if acceptable_hierarchies[company.parent_company.area_of_practice].include? company.area_of_practice

      raise StandardError, 'Incorrect Company Hierarchy. Please check parent company.'
    end
  end
end
