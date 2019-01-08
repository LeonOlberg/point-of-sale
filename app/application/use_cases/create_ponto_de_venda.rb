# frozen_string_literal: true

module UseCases
  class CreatePontoDeVenda
    def initialize(overrides = {})
      @pontos_de_venda_repository = overrides.fetch(:pontos_de_venda_repository) do
        Repositories::PontosDeVenda.new
      end
      @ponto_de_venda_class = overrides.fetch(:ponto_de_venda_class) do
        Entities::PontoDeVenda
      end
    end

    def perform(trading_name: nil, owner_name: nil, document: nil, coverage_area: nil, address: nil)
      ponto_de_venda = build_ponto_de_venda(trading_name, owner_name, document, coverage_area, address)

      @pontos_de_venda_repository.save(ponto_de_venda) if ponto_de_venda
    end

    private

    def build_ponto_de_venda(trading_name, owner_name, document, coverage_area, address)
      @ponto_de_venda_class.new(
        trading_name: trading_name,
        owner_name: owner_name,
        document: document,
        coverage_area: coverage_area,
        address: address
      )
    end
  end
end
