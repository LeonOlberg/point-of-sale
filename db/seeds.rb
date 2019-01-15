# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Entities::PontoDeVenda.create(trading_name: 'Lujinha do Seu Zé',  owner_name: 'José', document: '51.536.922/0001-59',
  coverage_area: '{ "type": "MultiPolygon", "coordinates": [[[
         [-23.575279, -46.637979],
         [-23.574856, -46.635050],
         [-23.577811, -46.635034],
         [-23.578587, -46.639359]
       ]]]}', address: '{ "type": "Point", "coordinates": [-23.576518, -46.636288] }')
