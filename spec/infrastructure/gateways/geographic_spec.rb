# frozen_string_literal: true

require 'rails_helper'

describe Gateways::Geographic, type: :gateways do
  context 'when generating local' do
    it 'returns local created by lat and lng' do
      latitude = -23.576518
      longitude = -46.636288
      rgeo_point = RGeo::Cartesian.factory.point(latitude, longitude)

      subject = described_class.new.local(latitude: latitude, longitude: longitude)

      expect(subject).to eq(rgeo_point)
    end
  end

  context 'when generating coverage area' do
    it 'returns coverage area created coverage area lat and lng' do
      coverage_area = '{"type": "MultiPolygon", "coordinates": [ [ [ [-23.575279, -46.637979], [-23.574856, -46.635050],
       [-23.577811, -46.635034], [-23.578587, -46.639359] ] ] ] }'
      rgeo_multi_poligon = RGeo::GeoJSON.decode(coverage_area)

      subject = described_class.new.coverage_area(coverage_area: coverage_area)

      expect(subject).to eq(rgeo_multi_poligon)
    end
  end

  context 'when verifying if a local is in a coverage area' do
    context 'when local it is in a coverage area' do
      it 'returns coverage area created coverage area lat and lng' do
        latitude = -23.576518
        longitude = -46.636288
        rgeo_point = RGeo::Cartesian.factory.point(latitude, longitude)
        coverage_area = '{"type": "MultiPolygon", "coordinates": [ [ [ [-23.575279, -46.637979],
         [-23.574856, -46.635050], [-23.577811, -46.635034], [-23.578587, -46.639359] ] ] ] }'
        rgeo_multi_poligon = RGeo::GeoJSON.decode(coverage_area)

        subject = described_class.new.local_within_coverage_area?(local: rgeo_point, coverage_area: rgeo_multi_poligon)

        expect(subject).to be true
      end
    end

    context 'when local it is not in a coverage area' do
      it 'returns coverage area created coverage area lat and lng' do
        latitude = -33.576518
        longitude = -76.636288
        rgeo_point = RGeo::Cartesian.factory.point(latitude, longitude)
        coverage_area = '{"type": "MultiPolygon", "coordinates": [ [ [ [-23.575279, -46.637979],
         [-23.574856, -46.635050], [-23.577811, -46.635034], [-23.578587, -46.639359] ] ] ] }'
        rgeo_multi_poligon = RGeo::GeoJSON.decode(coverage_area)

        subject = described_class.new.local_within_coverage_area?(local: rgeo_point, coverage_area: rgeo_multi_poligon)

        expect(subject).to be false
      end
    end
  end
end
