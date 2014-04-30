require 'money'
require 'money-rails'

module Spree
  class CurrencyRate < ActiveRecord::Base
    validates :rate, :base_currency, :target_currency, presence: true
    validates :rate, numericality: true
    monetize :rate

    def convert_to_won(price)
      price_usd = price.to_money("USD")
      Money::Money.add_rate(self.base_currency,self.target_currency,self.rate)
      price_in_won = Money::Money.us_dollar(price_usd).exchange_to('KRW')
      price_in_won
    end

  end
end
