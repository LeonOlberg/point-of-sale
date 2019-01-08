# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
gem 'ar-uuid', '~> 0.2.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails', '~> 2.5'
gem 'ffi-geos', '~> 2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2'
gem 'rgeo-geojson', '~> 2.1', '>= 2.1.1'
gem 'validates_cpf_cnpj', '~> 0.2.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry', '~> 0.12.2'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.1'
  gem 'rubocop', '~> 0.62.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
