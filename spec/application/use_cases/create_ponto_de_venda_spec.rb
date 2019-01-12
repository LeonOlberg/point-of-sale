# frozen_string_literal: true

require 'rails_helper'

describe UseCases::CreatePontoDeVenda, type: :use_case do
  context 'when creating a ponto de venda' do
    context 'when everything is allright' do
      it 'creates and persists a ponto de venda' do
        pontos_de_venda_repository = instance_spy(Repositories::PontosDeVenda)
        ponto_de_venda_class = class_double(Entities::PontoDeVenda)
        trading_name = 'this is a trading name'
        owner_name = 'this is an owner name'
        document = 'this is a document'
        coverage_area = 'this is a coverage area'
        address = 'this is an addres'
        ponto_de_venda = instance_double(Entities::PontoDeVenda,
          trading_name: trading_name, owner_name: owner_name, document: document,
          coverage_area: coverage_area, address: address)

        allow(ponto_de_venda_class).to receive(:new).and_return(ponto_de_venda)

        described_class.new(
          pontos_de_venda_repository: pontos_de_venda_repository,
          ponto_de_venda_class: ponto_de_venda_class
        ).perform(
          trading_name: trading_name,
          owner_name: owner_name,
          document: document,
          coverage_area: coverage_area,
          address: address
        )

        expect(pontos_de_venda_repository).to have_received(:save).with(ponto_de_venda)
      end
    end

    context 'when are any problems to build a ponto de venda' do
      it 'does not create and persist a ponto de venda' do
        pontos_de_venda_repository = instance_spy(Repositories::PontosDeVenda)
        ponto_de_venda_class = class_double(Entities::PontoDeVenda)

        allow(ponto_de_venda_class).to receive(:new).and_return(nil)
        allow(pontos_de_venda_repository).to receive(:save).and_return(nil)

        subject = described_class.new(
          pontos_de_venda_repository: pontos_de_venda_repository,
          ponto_de_venda_class: ponto_de_venda_class
        ).perform

        expect(pontos_de_venda_repository).to have_received(:save).with(nil)
        expect(subject).to be_nil
      end
    end
  end
end
