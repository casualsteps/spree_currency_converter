Spree::BaseHelper.module_eval do
  def display_price(product_or_variant,currency=nil)
    currency = if currency.nil? then Spree::Config[:presentation_currency] else currency end
    prices = product_or_variant.prices.select { |pr| pr.currency == currency }
    max_price = prices.max_by(&:price)
    min_price = prices.min_by(&:price)

    if !max_price || !min_price
      # probably means there's no variants. Let's try returning the master price if it exists, otherwise there must be an error
      return product_or_variant.master.display_price ? product_or_variant.master.display_price.to_html : "재고가 없습니다"
    elsif max_price.price == min_price.price
      max_price.display_price.to_html
    else
      min_price.display_price.to_html + " ~ " + max_price.display_price.to_html
    end
  end
end
