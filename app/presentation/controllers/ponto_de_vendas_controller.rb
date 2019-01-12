# frozen_string_literal: true

module Controllers
  class PontoDeVendasController < ApplicationController
    def index
      ponto_de_vendas = Repositories::PontosDeVenda.new.find_all

      if ponto_de_vendas.any?
        render status: 302, json: { message: 'Successfully found.', pdvs: ponto_de_vendas } and return
      else
        render status: 404, json: { message: 'Not found.' }
      end
    end

    def show
      ponto_de_vendas = find_by_lng_lat

      render status: 302, json: { message: 'Successfully found.', pdvs: ponto_de_vendas } and return if ponto_de_vendas
      render status: 404, json: { message: 'Not found.' }
    end

    def create
      created = create_ponto_de_venda

      render status: 201, json: { message: 'Successfully created.', id: created.id } and return if created
      render status: 422, json: { message: 'Unprocessable entity.' }
    end

    private

    def create_ponto_de_venda
      UseCases::CreatePontoDeVenda.new
        .perform(trading_name: params[:trading_name], owner_name: params[:owner_name], document: params[:document],
                 coverage_area: params[:coverage_area], address: params[:address])
    end

    def find_by_lng_lat
      UseCases::FindPontoDeVendaInCoverageArea.new
        .perform(lng: params[:lng], lat: params[:lat])
    end

    def set_ponto_de_venda
      @ponto_de_venda = PontoDeVenda.find(params[:id])
    end
  end
end
