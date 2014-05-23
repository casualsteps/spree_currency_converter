Spree::ProductsHelper.module_eval do
  def variant_price(variant,currency=nil)

    currency = if !currency.nil? then currency else Spree::Config[:presentation_currency] end

    if Spree::Config[:show_variant_full_price]
      variant_full_price(variant,currency)
    else
      variant_price_diff(variant,currency)
    end
  end

  def variant_price_diff(variant,currency)
    diff = variant.amount_in(currency) - variant.product.amount_in(currency)
    return nil if diff == 0
    amount = Spree::Money.new(diff.abs, { currency: currency }).to_html
    if diff > 0
      "(#{Spree.t(:add)}: #{amount}".html_safe
    else
      "(#{Spree.t(:subtract)}: #{amount}".html_safe
    end
  end

  def variant_full_price(variant,currency)
    product = variant.product
    unless product.variants.active(currency).all? { |v| v.price == product.price }
      Spree::Money.new(variant.amount_in(currency), { currency: currency }).to_html
    end
  end
end
