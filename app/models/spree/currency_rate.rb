module Spree
  class CurrencyRate < ActiveRecord::Base
    validates :rate, :base_currency, :target_currency, presence: true
    validates :rate, numericality: true
  end
end
