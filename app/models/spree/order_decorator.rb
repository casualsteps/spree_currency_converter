Spree::Order.class_eval do
  before_create :link_by_email,:set_presentation_currency

  def set_presentation_currency
    self.presentation_currency = Spree::Config[:presentation_currency] if Spree::Config[:presentation_currency] != nil
  end

  def display_presentation_item_total
    Spree::Money.new(self.presentation_item_total,{currency: self.presentation_currency})
  end

  def display_presentation_included_tax_total
    Spree::Money.new(self.presentation_included_tax_total,{currency: self.presentation_currency})
  end

  def display_presentation_additional_tax_total
    Spree::Money.new(self.presentation_additional_tax_total,{currency: self.presentation_currency})
  end

  def display_presentation_shipment_total
    Spree::Money.new(self.presentation_shipment_total,{currency: self.presentation_currency})
  end

  def display_presentation_payment_total
    Spree::Money.new(self.presentation_payment_total,{currency: self.presentation_currency})
  end

  def display_presentation_total
    Spree::Money.new(self.presentation_total, {currency: self.presentation_currency})
  end

end
