module Spree
  Spree::Variant.class_eval do
    after_save :save_default_price, :add_price_in_won

    def add_price_in_won
      rate = Spree::CurrencyRate.find_by(:base_currency => 'USD')
      presentation_price = self.price_in(Spree::Config[:presentation_currency])
      presentation_price = self.prices.new(currency: Spree::Config[:presentation_currency]) if presentation_price.blank?
      presentation_price.amount = rate.convert_to_won(self.price).amount
      if presentation_price && (presentation_price.changed? || presentation_price.new_record? || presentation_price.amount.present?)
        self.prices << presentation_price
        presentation_price.save!
      end
    end
  end
end
