# frozen_string_literal: true

require 'rails_helper'

describe Entities::PontoDeVenda, type: :entity do
  context 'when building a ponto de venda' do
    context 'when all information was given' do
      it 'builds a new ponto de venda' do
        trading_name = 'Lojinha do seu Zé'
        owner_name = 'José Silva'
        document = '51.536.922/0001-59'
        coverage_area = '{
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [-23.575279, -46.637979],
                [-23.574856, -46.635050],
                [-23.577811, -46.635034],
                [-23.578587, -46.639359]
              ]
            ]
          ]
        }'
        address = '{
          "type": "Point",
          "coordinates": [-23.576518, -46.636288]
        }'

        subject = described_class.new(
          trading_name: trading_name,
          owner_name: owner_name,
          document: document,
          coverage_area: coverage_area,
          address: address
        )

        expect(subject).to be_valid
      end
    end

    context 'when an attribute was not given' do
      it 'does not build a new ponto de venda if trading name was not given' do
        owner_name = 'José Silva'
        document = '51.536.922/0001-59'
        coverage_area = '{
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [-23.575279, -46.637979],
                [-23.574856, -46.635050],
                [-23.577811, -46.635034],
                [-23.578587, -46.639359]
              ]
            ]
          ]
        }'
        address = '{
          "type": "Point",
          "coordinates": [-23.576518, -46.636288]
        }'

        subject = described_class.new(
          owner_name: owner_name,
          document: document,
          coverage_area: coverage_area,
          address: address
        )

        expect(subject).to_not be_valid
      end

      it 'does not build a new ponto de venda if owner name was not given' do
        trading_name = 'Lojinha do seu Zé'
        document = '51.536.922/0001-59'
        coverage_area = '{
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [-23.575279, -46.637979],
                [-23.574856, -46.635050],
                [-23.577811, -46.635034],
                [-23.578587, -46.639359]
              ]
            ]
          ]
        }'
        address = '{
          "type": "Point",
          "coordinates": [-23.576518, -46.636288]
        }'

        subject = described_class.new(
          trading_name: trading_name,
          document: document,
          coverage_area: coverage_area,
          address: address
        )

        expect(subject).to_not be_valid
      end

      it 'does not build a new ponto de venda if document was not given' do
        trading_name = 'Lojinha do seu Zé'
        owner_name = 'José Silva'
        coverage_area = '{
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [-23.575279, -46.637979],
                [-23.574856, -46.635050],
                [-23.577811, -46.635034],
                [-23.578587, -46.639359]
              ]
            ]
          ]
        }'
        address = '{
          "type": "Point",
          "coordinates": [-23.576518, -46.636288]
        }'

        subject = described_class.new(
          trading_name: trading_name,
          owner_name: owner_name,
          coverage_area: coverage_area,
          address: address
        )

        expect(subject).to_not be_valid
      end

      it 'does not build a new ponto de venda if coverage area was not given' do
        trading_name = 'Lojinha do seu Zé'
        owner_name = 'José Silva'
        document = '51.536.922/0001-59'
        address = '{
          "type": "Point",
          "coordinates": [-23.576518, -46.636288]
        }'

        subject = described_class.new(
          trading_name: trading_name,
          owner_name: owner_name,
          document: document,
          address: address
        )

        expect(subject).to_not be_valid
      end

      it 'does not build a new ponto de venda if coverage area was not given' do
        trading_name = 'Lojinha do seu Zé'
        owner_name = 'José Silva'
        document = '51.536.922/0001-59'
        coverage_area = '{
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [-23.575279, -46.637979],
                [-23.574856, -46.635050],
                [-23.577811, -46.635034],
                [-23.578587, -46.639359]
              ]
            ]
          ]
        }'

        subject = described_class.new(
          trading_name: trading_name,
          owner_name: owner_name,
          document: document,
          coverage_area: coverage_area
        )

        expect(subject).to_not be_valid
      end
    end

    context 'when document is not valid' do
      it 'does not build a new ponto de venda' do
        trading_name = 'Lojinha do seu Zé'
        owner_name = 'José Silva'
        document = 'THIS IS NOT A CNPJ'
        coverage_area = '{
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [-23.575279, -46.637979],
                [-23.574856, -46.635050],
                [-23.577811, -46.635034],
                [-23.578587, -46.639359]
              ]
            ]
          ]
        }'
        address = '{
          "type": "Point",
          "coordinates": [-23.576518, -46.636288]
        }'

        subject = described_class.new(
          trading_name: trading_name,
          owner_name: owner_name,
          document: document,
          coverage_area: coverage_area,
          address: address
        )
        expect(subject).to_not be_valid
      end
    end
  end
end
