# frozen_string_literal: true

module Controllers
  class PontoDeVendasController < ApplicationController
    def index
      if params[:lat].present? && params[:lng].present?
        pontos_de_venda = find_by_lng_lat
      else
        pontos_de_venda = find_all
      end

      return_show(pontos_de_venda)
    end

    def show
      ponto_de_venda = pontos_de_venda_repository.find_by_id(params[:id])

      if ponto_de_venda
        render status: 302, json: { message: 'Successfully found.', pdv: ponto_de_venda } and return
      else
        render status: 404, json: { message: 'Not found.' }
      end
    end

    def create
      created = create_ponto_de_venda

      render status: 201, json: { message: 'Successfully created.', id: created.id } and return if created
      render status: 422, json: { message: 'Unprocessable entity.' }
    end

    private

    def return_show(pontos_de_venda)
      if pontos_de_venda.any?
        render status: 302, json: { message: 'Successfully found.', pdvs: pontos_de_venda } and return
      else
        render status: 404, json: { message: 'Not found.' }
      end
    end

    def find_all
      pontos_de_venda_repository.find_all
    end

    def create_ponto_de_venda
      UseCases::CreatePontoDeVenda.new
        .perform(trading_name: params[:trading_name], owner_name: params[:owner_name], document: params[:document],
                 coverage_area: params[:coverage_area], address: params[:address])
    end

    def find_by_lng_lat
      UseCases::FindPontoDeVendaByCoverageArea.new
        .perform(longitude: params[:lng], latitude: params[:lat])
    end

    def set_ponto_de_venda
      @ponto_de_venda = PontoDeVenda.find(params[:id])
    end

    def pontos_de_venda_repository
      @pontos_de_venda_repository ||= Repositories::PontosDeVenda.new
    end
  end
end
