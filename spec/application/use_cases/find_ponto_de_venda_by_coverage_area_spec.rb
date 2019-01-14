# frozen_string_literal: true

require 'rails_helper'

describe UseCases::FindPontoDeVendaByCoverageArea, type: :use_case do
  context 'when finding some pontos de venda by coverage area' do
    context 'when parameters are valid and has pontos de venda that cover' do
      it 'returns all pontos de venda that cover area' do
        pontos_de_venda_repository = instance_double(Repositories::PontosDeVenda)
        geographic_service = instance_spy(Services::Geographic)
        first_ponto_de_venda = 'first_ponto_de_venda'
        second_ponto_de_venda = 'second_ponto_de_venda'
        pontos_de_venda = [first_ponto_de_venda, second_ponto_de_venda]
        latitude = '-23.576071'
        longitude = '-46.6374977'

        allow(pontos_de_venda_repository).to receive(:find_all).and_return(pontos_de_venda)

        described_class.new(
          pontos_de_venda_repository: pontos_de_venda_repository,
          geographic_service: geographic_service
        ).perform(latitude: latitude, longitude: longitude)

        expect(geographic_service).to have_received(:find_in_coverage_area_by_lat_and_lng)
          .with(latitude: latitude.to_f, longitude: longitude.to_f, pontos_de_venda: pontos_de_venda)
      end
    end

    context 'when parameters are valid but has not pontos de venda that cover' do
      it 'returns no one pontos de venda' do
        pontos_de_venda_repository = instance_double(Repositories::PontosDeVenda)
        geographic_service = instance_spy(Services::Geographic)
        pontos_de_venda = []
        latitude = '-23.576071'
        longitude = '-46.6374977'

        allow(pontos_de_venda_repository).to receive(:find_all).and_return(pontos_de_venda)

        described_class.new(
          pontos_de_venda_repository: pontos_de_venda_repository,
          geographic_service: geographic_service
        ).perform(latitude: latitude, longitude: longitude)

        expect(geographic_service).to_not have_received(:find_in_coverage_area_by_lat_and_lng)
      end
    end

    context 'when parameters are invalid but has pontos de venda that cover' do
      it 'returns no one pontos de venda' do
        pontos_de_venda_repository = instance_double(Repositories::PontosDeVenda)
        geographic_service = instance_spy(Services::Geographic)
        first_ponto_de_venda = 'first_ponto_de_venda'
        second_ponto_de_venda = 'second_ponto_de_venda'
        pontos_de_venda = [first_ponto_de_venda, second_ponto_de_venda]
        latitude = nil
        longitude = nil

        allow(pontos_de_venda_repository).to receive(:find_all).and_return(pontos_de_venda)

        described_class.new(
          pontos_de_venda_repository: pontos_de_venda_repository,
          geographic_service: geographic_service
        ).perform(latitude: latitude, longitude: longitude)

        expect(geographic_service).to_not have_received(:find_in_coverage_area_by_lat_and_lng)
      end
    end
  end
end
