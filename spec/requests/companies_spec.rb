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
    let(:valid_attributes) { { company: { area_of_practice: 'country', required_employees_amount: 1 } } }

    context 'when the request is valid' do
      before { post '/companies', params: valid_attributes }

      it 'creates a company' do
        expect(json['area_of_practice_cd']).to eq('country')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /companies/:id' do
    let(:valid_attributes) { { company: { required_employees_amount: 2 } } }

    context 'when the record exists' do
      before { put "/companies/#{company_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
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