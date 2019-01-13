# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'controllers' do
    resources :ponto_de_vendas, only: [:create, :show, :index]
  end
end
