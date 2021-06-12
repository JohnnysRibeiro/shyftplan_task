class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all
    json_response(@companies)
  end

  # GET /companies_without_required_employees
  def companies_without_required_employees
    @companies = Company::CheckCompaniesEmployees.new.call
    json_response(@companies)
  end

  # POST /companies
  def create
    @company = Company::CreateCompany.new(company_params).call
    if @company.is_a? Company
      json_response(@company, :created)
    else
      json_response(@company, status: 400)
    end
  end

  # GET /companies/:id
  def show
    json_response(@company)
  end

  # PUT /companies/:id
  def update
    @company.update(company_params)
    head :no_content
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
    head :no_content
  end

  private

  def company_params
    # whitelist params
    params.require(:company).permit(:area_of_practice, :required_employees_amount, :parent_company_id)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
