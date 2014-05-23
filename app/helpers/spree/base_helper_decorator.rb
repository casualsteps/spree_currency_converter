Spree::BaseHelper.module_eval do
  def display_price(product_or_variant,currency=nil)
    currency = if currency.nil? then Spree::Config[:presentation_currency] else currency end
    product_or_variant.price_in(currency).display_price.to_html
  end
end
