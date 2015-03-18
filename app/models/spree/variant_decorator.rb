module Spree
  Spree::Variant.class_eval do
    after_save :add_presentation_price

    def add_presentation_price
      currency = Spree::Config[:currency]
      presentation = Spree::Config[:presentation_currency]
      presentation_price = self.price_in(presentation)

      amount = self.price.to_money(currency).exchange_to(presentation).amount
      presentation_price.amount = amount 
      return unless presentation_price.changed? || presentation_price.new_record?
      self.prices << presentation_price
      presentation_price.save!
    end
  end
end
