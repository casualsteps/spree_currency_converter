Spree::BaseHelper.module_eval do
  def display_price(product_or_variant,currency=nil)
    currency = if currency.nil? then Spree::Config[:presentation_currency] else currency end
    prices = product_or_variant.prices.select { |pr| pr.currency == currency }
    max_price = prices.max_by(&:price)
    min_price = prices.min_by(&:price)

    if !max_price || !min_price
      "재고가 없습니다"
    if max_price.price == min_price.price
      max_price.display_price.to_html
    else
      min_price.display_price.to_html + " ~ " + max_price.display_price.to_html
    end
  end
end
