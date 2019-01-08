# frozen_string_literal: true

module UseCases
  class FindPontoDeVendaInCoverageArea
    def initialize(overrides: {})
      @pontos_de_venda_repository = overrides.fetch(:pontos_de_venda_repository) do
        Repositories::PontosDeVenda.new
      end
    end

    def perform(latitude:, longitude:)
      pontos_de_venda = @pontos_de_venda_repository.find_all
      geo_input_point = generate_point(latitude, longitude)
      find_by_latitude_and_longitude(pontos_de_venda, geo_input_point)

      in_coverage_area
    end

    private

    def find_by_latitude_and_longitude(pontos_de_venda, geo_input_point)
      pontos_de_venda.each do |pdv|
        geo_coverage_area = generate_polygon(pdv.coverage_area)
        in_coverage_area << geo_coverage_area if geo_input_point.within?(geo_coverage_area)
      end
    end

    def in_coverage_area
      @in_coverage_area ||= []
    end

    def generate_point(latitude, longitude)
      RGeo::Cartesian.factory.point(latitude, longitude)
    end

    def generate_polygon(coverage_area)
      RGeo::GeoJSON.decode(coverage_area)
    end
  end
end
