Spree::Order.class_eval do
  state_machine do
    after_transition to: :complete, do: :store_current_rate
  end

  def store_current_rate
    self.update_attributes(rate: Money.default_bank.get_rate('USD', 'KRW'))
  end

  def presentation_currency
    Spree::Config[:presentation_currency]
  end

  def to_presentation(amount)
    @bank ||= Money.default_bank if rate.zero?
    @bank ||= Money::Bank::VariableExchange.new.tap {|b| b.add_rate('USD', 'KRW', rate) }
    currency = Spree::Config[:presentation_currency]
    @bank.exchange_with(amount.to_money(Spree::Config[:currency]), currency)
  end

  def display_presentation_item_total
    Spree::Money.new(to_presentation(item_total),{currency: presentation_currency}).to_html
  end

  def display_presentation_included_tax_total
    Spree::Money.new(to_presentation(included_tax_total),{currency: presentation_currency}).to_html
  end

  def display_presentation_additional_tax_total
    Spree::Money.new(to_presentation(additional_tax_total),{currency: presentation_currency}).to_html
  end

  def display_presentation_shipment_total
    Spree::Money.new(to_presentation(shipment_total),{currency: presentation_currency}).to_html
  end

  def display_presentation_payment_total
    Spree::Money.new(to_presentation(payment_total),{currency: presentation_currency}).to_html
  end

  def display_presentation_total
    Spree::Money.new(to_presentation(total), {currency: presentation_currency}).to_html
  end
end
