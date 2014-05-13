module Spree
  Spree::Variant.class_eval do
    after_save :add_price_in_won

    def add_price_in_won
      self.prices.push Spree::Price.new(variant: self, amount: self.default_price.in_won_s, currency: 'KRW')
    end
  end
end
