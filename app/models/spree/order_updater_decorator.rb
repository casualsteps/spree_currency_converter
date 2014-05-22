Spree::OrderUpdater.class_eval do

  def update_totals
    order.payment_total = payments.completed.sum(:amount)
    update_item_total
    update_shipment_total
    update_adjustment_total
    presentation_currency = if Spree::Config[:presentation_currency] then Spree::Config[:presentation_currency] end
    settlement_currency = if Spree::Config[:settlement_currency] then Spree::Config[:settlement_currency] end
    if presentation_currency and settlement_currency
      @rate = Spree::CurrencyRate.find_by(:target_currency => presentation_currency, :base_currency => settlement_currency)
      update_presentation_payment_total
      update_presentation_item_total
      update_presentation_shipment_total
      update_presentation_adjustment_total
    end
  end

  def update_presentation_payment_total
    order.presentation_payment_total = @rate.convert_to_won_f(order.payment_total)
  end

  def update_presentation_item_total
    order.presentation_item_total = @rate.convert_to_won_f(order.item_total)
  end

  def update_presentation_shipment_total
    order.presentation_shipment_total = @rate.convert_to_won_f(order.shipment_total)
  end

  def update_presentation_adjustment_total
    order.presentation_included_tax_total = @rate.convert_to_won_f(order.included_tax_total)
    order.presentation_additional_tax_total = @rate.convert_to_won_f(order.additional_tax_total)
    order.presentation_adjustment_total = @rate.convert_to_won_f(order.adjustment_total)
  end

end

