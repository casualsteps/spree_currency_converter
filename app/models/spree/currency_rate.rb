require 'monetize/core_extensions'

module Spree
  class CurrencyRate
    def self.find_by(*args)
      new
    end

    def convert_to_usd(amount)
      amount.to_money("KRW").exchange_to('USD')
    end

    def convert_to_won(amount)
      amount.to_money("USD").exchange_to('KRW')
    end
  end
end
