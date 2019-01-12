# frozen_string_literal: true

FactoryBot.define do
  factory :ponto_de_venda, class: Entities::PontoDeVenda do
    trading_name { 'Lujinha do Seu Zé' }
    owner_name { 'José' }
    document { '51.536.922/0001-59' }
    coverage_area do
      '{
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
    end
    address do
      '{
        "type": "Point",
        "coordinates": [-23.576518, -46.636288]
      }'
    end
  end
end
