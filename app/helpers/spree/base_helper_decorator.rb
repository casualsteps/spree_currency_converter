Spree::BaseHelper.module_eval do
  def display_price(product_or_variant,currency=nil)
    currency = if currency.nil? then Spree::Config[:presentation_currency] else currency end
    price = product_or_variant.prices.select { |pr| pr.currency == currency }.first
    price.display_price.to_html
  end
end
