Spree::Price.class_eval do

  def in_won
    rate = Spree::CurrencyRate.find_by(:base_currency => self.currency)
    rate.convert_to_won(self.amount)
  end

  def in_won_s
    price_in_won_s = self.in_won.to_s
    price_in_won_s
  end
end
