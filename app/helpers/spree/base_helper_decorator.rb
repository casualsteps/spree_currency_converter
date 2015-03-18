Spree::BaseHelper.module_eval do
  # Convert from default currency (USD), to a display currency (default KRW)         
  def format_currency(amount, opts = {})
    opts.reverse_merge!(to: Spree::Config[:presentation_currency], from: Spree::Config[:currency])
    money = case amount
    when Spree::Money
      amount.money
    when ::Money
      amount
    else
      amount.to_money(opts[:from])
    end.exchange_to(opts[:to])
    return Spree::Money.new(money, currency: opts[:to])
  end
                                                                   
  # This will format the price as HTML for display on the front-end
  def display_currency(amount, opts = {})
    format_currency(amount, opts).to_html
  end
end
