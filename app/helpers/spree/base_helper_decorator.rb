Spree::BaseHelper.module_eval do
  def display_price(product_or_variant,currency=nil)
    currency = if currency.nil? then Spree::Config[:presentation_currency] else currency end
    prices = product_or_variant.prices.select { |pr| pr.currency == currency && pr.variant.in_stock? }
    if prices.empty? && product_or_variant.master
      prices = product_or_variant.master.prices.select { |pr| pr.currency == currency }
    end
    max_price = prices.max_by(&:price)
    min_price = prices.min_by(&:price)

    if prices.empty?
      return "재고가 없습니다"
    elsif max_price.price == min_price.price
      max_price.display_price.to_html
    else
      ### Temporary - naver only allows one price per product, so applying this patch
      # min_price.display_price.to_html + " ~ " + max_price.display_price.to_html
      min_price.display_price.to_html + " ~"
    end
  end
end
