Spree::LineItem.class_eval do

  def presentation_single_money(currency=nil)
    presentation_currency = if !currency.nil? then currency else Spree::Config[:presentation_currency] end
    if !presentation_currency.nil?
      @rate = Spree::CurrencyRate.find_by(:target_currency => presentation_currency)
      Spree::Money.new @rate.convert_to_won(price).amount, { currency: presentation_currency }
    else
      Spree::Money.new(price, { currency: currency })
    end
  end
end
