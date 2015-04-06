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

  # Accepts a symbol representing another amount on the order model, and
  # converts it to the presentation currency.
  # Example:
  #   order.to_presentation(:total)
  def to_presentation(method, target_currency = "KRW")
    if target_currency == "KRW"
      source_currency = "USD" 
    else
      source_currency = "KRW"
    end
    @bank ||= Money.default_bank if rate.zero?
    @bank ||= Money::Bank::VariableExchange.new.tap {|b| b.add_rate(source_currency, target_currency, rate) }
    amount = self.__send__(method)
    money = @bank.exchange_with(amount.to_money(Spree::Config[:currency]), target_currency)
    Spree::Money.new(money ,{currency: target_currency})
  end
end
