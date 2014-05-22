Spree::Order.class_eval do
  before_create :link_by_email,:set_presentation_currency

  def set_presentation_currency
    self.presentation_currency = Spree::Config[:presentation_currency] if Spree::Config[:presentation_currency] != nil
  end

end
