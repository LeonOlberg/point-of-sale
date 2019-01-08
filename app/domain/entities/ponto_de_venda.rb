# frozen_string_literal: true

module Entities
  class PontoDeVenda < ApplicationRecord
    validates :trading_name, presence: true
    validates :owner_name, presence: true
    validates :document, presence: true, cnpj: true
    validates :coverage_area, presence: true
    validates :address, presence: true
  end
end
