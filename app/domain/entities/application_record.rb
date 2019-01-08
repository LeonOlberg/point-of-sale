# frozen_string_literal: true

module Entities
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
