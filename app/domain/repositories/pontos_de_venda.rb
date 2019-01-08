# frozen_string_literal: true

module Repositories
  class PontosDeVenda
    def initialize
      @domain = Entities::PontoDeVenda
    end

    def save(domain)
      domain.save
    end

    def find_by_id(id)
      @domain.find_by(id: id)
    end

    def find_all
      @domain.all
    end
  end
end
