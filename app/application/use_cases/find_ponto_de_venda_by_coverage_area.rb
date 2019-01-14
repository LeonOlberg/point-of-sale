# frozen_string_literal: true

module UseCases
  class FindPontoDeVendaByCoverageArea
    def initialize(overrides = {})
      @pontos_de_venda_repository = overrides.fetch(:pontos_de_venda_repository) do
        Repositories::PontosDeVenda.new
      end
      @geographic_service = overrides.fetch(:geographic_service) do
        Services::Geographic.new
      end
    end

    def perform(latitude: nil, longitude: nil)
      pontos_de_venda = @pontos_de_venda_repository.find_all

      return unless (latitude && longitude) && pontos_de_venda.any?

      in_coverage_area(latitude.to_f, longitude.to_f, pontos_de_venda)
    end

    private

    def in_coverage_area(latitude, longitude, pontos_de_venda)
      @geographic_service.find_in_coverage_area_by_lat_and_lng(latitude: latitude, longitude: longitude,
                                                               pontos_de_venda: pontos_de_venda)
    end
  end
end
