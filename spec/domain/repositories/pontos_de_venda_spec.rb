# frozen_string_literal: true

require 'rails_helper'

describe Repositories::PontosDeVenda, type: :repositories do
  context 'when saving a ponto de venda' do
    it 'persists a ponto de venda' do
      ponto_de_venda = build(:ponto_de_venda)

      subject = described_class.new.save(ponto_de_venda)

      expect(subject).to eq(ponto_de_venda)
      expect(Entities::PontoDeVenda.first).to eq(subject)
    end
  end

  context 'when finding by id' do
    it 'returns a ponto de venda by id' do
      ponto_de_venda = create(:ponto_de_venda)

      subject = described_class.new.find_by_id(ponto_de_venda.id)

      expect(subject).to eq(ponto_de_venda)
      expect(Entities::PontoDeVenda.first).to eq(subject)
    end
  end

  context 'when finding all' do
    it 'returns all pontos de venda' do
      first_ponto_de_venda = create(:ponto_de_venda)
      second_ponto_de_venda = create(:ponto_de_venda)

      subject = described_class.new.find_all

      expect(subject).to eq([first_ponto_de_venda, second_ponto_de_venda])
      expect(Entities::PontoDeVenda.all).to eq(subject)
    end
  end
end
