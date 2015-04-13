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
    amount = self.__send__(method)
    if target_currency == "KRW"
      @bank ||= Money.default_bank if rate.zero?
      @bank ||= Money::Bank::VariableExchange.new.tap {|b| b.add_rate("USD", target_currency, rate) }
      money = @bank.exchange_with(amount.to_money(Spree::Config[:currency]), target_currency)
    else
      money = amount.to_money(Spree::Config[:currency])
    end
    Spree::Money.new(money ,{currency: target_currency})
  end
end
