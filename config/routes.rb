# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :controllers do
    resources :ponto_de_vendas, only: [:create, :show, :index]
  end
end
