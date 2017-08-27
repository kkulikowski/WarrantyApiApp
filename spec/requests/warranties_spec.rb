require 'rails_helper'

RSpec.describe 'Warranties API' do
  # Initialize the test data
  let!(:product) { create(:product) }
  let!(:warranties) { create_list(:warranty, 3, product_id: product.id) }
  let(:product_id) { product.id }
  let(:id) { warranties.first.id }

  # Test suite for GET /products/:product_id/warranties
  describe 'GET /products/:product_id/warranties' do
    before { get "/products/#{product_id}/warranties" }

    context 'when product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all product warranties' do
        expect(json.size).to eq(3)
      end
    end

    context 'when product does not exist' do
      let(:product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  # Test suite for GET /products/:product_id/warranties/:id
  describe 'GET /products/:product_id/warranties/:id' do
    before { get "/products/#{product_id}/warranties/#{id}" }

    context 'when product warranty exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the warranty' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when product warranty does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Warranty/)
      end
    end
  end

  # Test suite for PUT /products/:product_id/warranties
  describe 'POST /products/:product_id/warranties' do
    let(:valid_attributes) { { name: 'Giant Glory' } }

    context 'when request attributes are valid' do
      before { post "/products/#{product_id}/warranties", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/products/#{product_id}/warranties", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /products/:product_id/warranties/:id
  describe 'PUT /products/:product_id/warranties/:id' do
    let(:valid_attributes) { { name: 'Specialized Demo' } }

    before { put "/products/#{product_id}/warranties/#{id}", params: valid_attributes }

    context 'when warranty exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the warranty' do
        updated_warranty = Warranty.find(id)
        expect(updated_warranty.name).to match(/Specialized Demo/)
      end
    end

    context 'when the warranty does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Warranty/)
      end
    end
  end

  # Test suite for DELETE /products/:id
  describe 'DELETE /products/:id' do
    before { delete "/products/#{product_id}/warranties/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end