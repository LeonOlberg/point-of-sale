# frozen_string_literal: true

module Services
  class Geographic
    def initialize(overrides = {})
      @geographic_gateway = overrides.fetch(:geographic_gateway) do
        Gateways::Geographic.new
      end
    end

    def find_in_coverage_area_by_lat_and_lng(latitude:, longitude:, pontos_de_venda:)
      local = @geographic_gateway.local(latitude: latitude, longitude: longitude)

      find_by_latitude_and_longitude(pontos_de_venda, local)
    end

    private

    def find_by_latitude_and_longitude(pontos_de_venda, local)
      pontos_de_venda.select do |pdv|
        pdv_coverage_area = @geographic_gateway.coverage_area(coverage_area: pdv.coverage_area)

        in_coverage_area << pdv if @geographic_gateway.local_within_coverage_area?(local: local,
                                                                                   coverage_area: pdv_coverage_area)
      end
    end

    def in_coverage_area
      @in_coverage_area ||= []
    end
  end
end
