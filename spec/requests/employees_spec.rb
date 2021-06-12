# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  # initialize test data
  let!(:company) { create(:company) }
  let!(:employees) { create_list(:employee, 10, company_id: company.id) }
  let(:employee_id) { employees.first.id }

  describe 'GET /employees/:id' do
    before { get "/employees/#{employee_id}" }

    context 'when the record exists' do
      it 'returns the employee' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(employee_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:employee_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Employee/)
      end
    end
  end

  describe 'POST /employees' do
    let(:valid_attributes) { { employee: { company_id: company.id } } }

    context 'when the request is valid' do
      before { post '/employees', params: valid_attributes }

      it 'creates a employee within the correct company' do
        expect(json['company_id']).to eq(company.id)
        expect(company.reload.employees.last).to eq(Employee.last)
        expect(Employee.last.company).to eq(company)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /employees/:id' do
    let(:valid_attributes) { { employee: { company_id: company.id } } }

    context 'when the record exists' do
      before { put "/employees/#{employee_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
        expect(company.reload.employees.last).to eq(Employee.last)
        expect(Employee.find(employee_id).company).to eq(company)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /employees/:id' do
    before { delete "/employees/#{employee_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
