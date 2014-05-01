Spree::Price.class_eval do

  def price_in_won
    rate = Spree::CurrencyRate.find_by(:base_currency => self.currency)
    rate.convert_to_won(self.amount)
  end

  def price_in_won_s
    price_in_won_s = self.price_in_won.to_s
    price_in_won_s
  end
end
