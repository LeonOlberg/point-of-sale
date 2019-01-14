# frozen_string_literal: true

require 'rails_helper'

describe Controllers::PontoDeVendasController, type: :controller do
  describe 'GET #index' do
    describe 'when searching all pontos de venda' do
      it 'returns all found pontos de venda' do
        2.times { create(:ponto_de_venda) }

        get :index, params: {}

        expect(response).to have_http_status(:found)
      end
    end

    describe 'when searching pontos de venda by lat and lng' do
      it 'returns all found pontos de venda' do
        2.times { create(:ponto_de_venda) }
        lat = -23.576518
        lng = -46.636288

        get :index, params: { lat: lat, lng: lng }

        expect(response).to have_http_status(:found)
      end
    end

    describe 'when has not pontos de venda' do
      it 'returns all found pontos de venda' do
        get :index, params: {}

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #show' do
    describe 'when has ponto de venda to given id' do
      it 'returns a success response' do
        ponto_de_venda = create(:ponto_de_venda)

        get :show, params: { id: ponto_de_venda.id }

        expect(response).to have_http_status(:found)
      end
    end

    describe 'when has not ponto de venda to given id' do
      it 'returns a success response' do
        ponto_de_venda_id = 'an-random-id'

        get :show, params: { id: ponto_de_venda_id }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'renders a JSON response with the new ponto_de_venda' do
        ponto_de_venda_valid_attributes = attributes_for(:ponto_de_venda)

        post :create, params: ponto_de_venda_valid_attributes, format: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new ponto_de_venda' do
        ponto_de_venda_invalid_attributes = attributes_for(:ponto_de_venda, address: nil)

        post :create, params: ponto_de_venda_invalid_attributes, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
