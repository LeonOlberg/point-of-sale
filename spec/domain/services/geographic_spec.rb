# frozen_string_literal: true

require 'rails_helper'

describe Services::Geographic, type: :domain_services do
  context 'when finding in coverage area by lat and lng' do
    context 'when lat lng is in coverage area' do
      it 'returns an array with pontos de venda that cover the area' do
        latitude = -23.576518
        longitude = -46.636288
        ponto_de_venda_that_cover_area = create(:ponto_de_venda,
          coverage_area: '{"type": "MultiPolygon", "coordinates": [[[[-23.575279, -46.637979], [-23.574856, -46.635050],
           [-23.577811, -46.635034], [-23.578587, -46.639359]]]]}')
        ponto_de_venda_that_does_not_cover_area = create(:ponto_de_venda,
          coverage_area: '{"type": "MultiPolygon", "coordinates": [[[[-43.36556,-22.99669 ], [-43.36539,-23.01928 ],
           [-43.26583,-23.01802 ], [-43.25724,-23.00649 ]]]]}')
        pontos_de_venda = [ponto_de_venda_that_cover_area, ponto_de_venda_that_does_not_cover_area]

        subject = described_class.new.find_in_coverage_area_by_lat_and_lng(latitude: latitude, longitude: longitude,
                                                                           pontos_de_venda: pontos_de_venda)

        expect(subject).to contain_exactly(ponto_de_venda_that_cover_area)
      end
    end

    context 'when lat lng it is not in coverage area' do
      it 'returns an array with no one pontos de venda' do
        latitude = -45.576518
        longitude = -70.636288
        ponto_de_venda_that_cover_area = create(:ponto_de_venda,
          coverage_area: '{"type": "MultiPolygon", "coordinates": [[[[-23.575279, -46.637979], [-23.574856, -46.635050],
           [-23.577811, -46.635034], [-23.578587, -46.639359]]]]}')
        ponto_de_venda_that_does_not_cover_area = create(:ponto_de_venda,
          coverage_area: '{"type": "MultiPolygon", "coordinates": [[[[-43.36556,-22.99669 ], [-43.36539,-23.01928 ],
           [-43.26583,-23.01802 ], [-43.25724,-23.00649 ]]]]}')
        pontos_de_venda = [ponto_de_venda_that_cover_area, ponto_de_venda_that_does_not_cover_area]

        subject = described_class.new.find_in_coverage_area_by_lat_and_lng(latitude: latitude, longitude: longitude,
                                                                           pontos_de_venda: pontos_de_venda)

        expect(subject).to be_empty
      end
    end
  end
end
