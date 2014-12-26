require 'monetize/core_extensions'

module Spree
  class CurrencyRate < ActiveRecord::Base
    validates :rate, :base_currency, :target_currency, presence: true
    validates :rate, numericality: true
    default_scope { order('spree_currency_rates.created_at DESC') }

    def convert_to_usd(amount)
      amount_in_krw = amount.to_money("KRW")
      usd_rate = 1 / self.rate
      ::Money.add_rate(self.target_currency,self.base_currency,usd_rate)
      amount_in_usd = ::Money.new(amount_in_krw,'KRW').exchange_to('USD')
      amount_in_usd
    end

    def convert_to_won(amount)
      amount_in_usd = amount.to_money("USD")
      ::Money.add_rate(self.base_currency,self.target_currency,self.rate)
      amount_in_won = ::Money.us_dollar(amount_in_usd).exchange_to('KRW')
      amount_in_won
    end

    def convert_to_won_s(amount)
      amount_in_won = self.convert_to_won(amount)
      amount_in_won_s = amount_in_won.to_s
      amount_in_won_s
    end

    def convert_to_won_f(amount)
      amount_in_won = self.convert_to_won(amount)
      amount_in_won.to_f
    end

  end
end
