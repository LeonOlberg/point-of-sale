# frozen_string_literal: true

module Gateways
  class Geographic
    def initialize(overrides = {})
      @rgeo_cartesian = overrides.fetch(:rgeo_cartesian) do
        RGeo::Cartesian
      end
      @rgeo_geo_json = overrides.fetch(:rgeo_geo_json) do
        RGeo::GeoJSON
      end
    end

    def local(latitude:, longitude:)
      @rgeo_cartesian.factory.point(latitude, longitude)
    end

    def coverage_area(coverage_area:)
      @rgeo_geo_json.decode(coverage_area)
    end

    def local_within_coverage_area?(local:, coverage_area:)
      local.within?(coverage_area)
    end
  end
end
