module Spree
  Spree::Variant.class_eval do
    after_save :add_price_in_won

    def add_price_in_won
      rate = Spree::CurrencyRate.find_by(:base_currency => 'USD')
      self.prices.push Spree::Price.new(variant: self, amount: rate.convert_to_won(self.price), currency: 'KRW')
    end
  end
end
