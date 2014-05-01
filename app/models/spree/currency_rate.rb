require 'money'
require 'money-rails'

module Spree
  class CurrencyRate < ActiveRecord::Base
    validates :rate, :base_currency, :target_currency, presence: true
    validates :rate, numericality: true

    def convert_to_won(amount)
      amount_in_usd = amount.to_money("USD")
      Money::Money.add_rate(self.base_currency,self.target_currency,self.rate)
      amount_in_won = Money::Money.us_dollar(amount_in_usd).exchange_to('KRW')
      amount_in_won
    end

  end
end
