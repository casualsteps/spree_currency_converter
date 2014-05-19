module Spree
  Spree::Variant.class_eval do
    after_save :save_default_price, :add_price_in_won

    def add_price_in_won
      rate = Spree::CurrencyRate.find_by(:base_currency => 'USD')
      secondary_price = self.price_in(Spree::Config[:secondary_currency])
      secondary_price = self.prices.new(currency: Spree::Config[:secondary_currency]) if secondary_price.blank?
      secondary_price.amount = rate.convert_to_won(self.price).amount
      if secondary_price && (secondary_price.changed? || secondary_price.new_record? || secondary_price.amount.present?)
        self.prices << secondary_price
      end
    end
  end
end
