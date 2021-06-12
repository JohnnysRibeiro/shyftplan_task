class Company::CheckCompaniesEmployees < ApplicationBusiness
  def initialize
  end

  def call
    Company.all.map { |company| company_with_problem(company) }.compact
  end

  private

  def company_with_problem(company)
    @sub_companies_employee_count = 0
    get_sub_companies_employees(company)
    total_employees = company.employees.count + @sub_companies_employee_count
    return company if total_employees < company.required_employees_amount
  end

  def get_sub_companies_employees(company)
    if company.sub_companies.present?
      @sub_companies_employee_count += company.sub_companies.map { |sub_company| sub_company.employees.count }.sum
      company.sub_companies.each do |sub_company|
        get_sub_companies_employees(sub_company)
      end
    end
  end
end