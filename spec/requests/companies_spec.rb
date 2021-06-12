# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  # initialize test data
  let!(:companies) { create_list(:company, 10) }
  let(:company_id) { companies.first.id }

  describe 'GET /companies' do
    before { get '/companies' }

    it 'returns companies' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /companies_without_required_employees' do
    context 'when there is only one company with the correct amount of employees' do
      before do
        create_list(:employee, 10, company_id: company_id)
        get '/companies_without_required_employees'
      end

      it 'returns companies' do
        expect(json).not_to be_empty
        expect(json.size).to eq(9)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /companies/:id' do
    before { get "/companies/#{company_id}" }

    context 'when the record exists' do
      it 'returns the company' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(company_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:company_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Company/)
      end
    end
  end

  describe 'POST /companies' do
    let(:valid_attributes) do
      { company: { area_of_practice: 'city', required_employees_amount: 1, parent_company_id: company_id } }
    end
    let(:invalid_attributes) do
      { company: { area_of_practice: 'country', required_employees_amount: 1, parent_company_id: company_id } }
    end

    context 'when the request is valid' do
      before { post '/companies', params: valid_attributes }

      it 'creates a company' do
        expect(json['area_of_practice_cd']).to eq('city')
        expect(Company.last.parent_company).to eq(Company.find(company_id))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/companies', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Incorrect Company Hierarchy. Please check parent company./)
      end
    end
  end

  describe 'PUT /companies/:id' do
    let(:valid_attributes) { { company: { area_of_practice: 'city', parent_company_id: companies.last.id } } }

    context 'when the record exists' do
      before { put "/companies/#{company_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
        expect(Company.find(company_id).area_of_practice).to eq(:city)
        expect(Company.find(company_id).parent_company).to eq(companies.last)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /companies/:id' do
    before { delete "/companies/#{company_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
