Spree::BaseHelper.module_eval do
  def display_price(product_or_variant,currency=nil)
    currency = if currency.nil? then Spree::Config[:presentation_currency] else currency end
    min_price = product_or_variant.prices.where(currency: currency).order(amount: :asc).first
    max_price = product_or_variant.prices.where(currency: currency).order(amount: :desc).first

    if max_price == min_price.price
      max_price.display_price.to_html
    else
      ### Temporary - naver only allows one price per product, so applying this patch
      # min_price.display_price.to_html + " ~ " + max_price.display_price.to_html
      min_price.display_price.to_html + " ~"
    end
  end
end
