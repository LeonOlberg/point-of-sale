# frozen_string_literal: true

module Entities
  class PontoDeVenda < ApplicationRecord
    validates :trading_name, presence: true
    validates :owner_name, presence: true
    validates :document, presence: true, cnpj: true
    validates :coverage_area, presence: true
    validates :address, presence: true

    def address_json
      JSON.parse(address)
    end

    def coverage_area_json
      JSON.parse(coverage_area)
    end
  end
end
