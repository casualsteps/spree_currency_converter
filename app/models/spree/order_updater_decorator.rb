Spree::OrderUpdater.class_eval do

  def update_totals
    order.payment_total = payments.completed.sum(:amount)
    update_item_total
    update_shipment_total
    update_adjustment_total
    update_presentation_totals
  end

  def update_presentation_totals
    settlement_currency = if Spree::Config[:settlement_currency] then Spree::Config[:settlement_currency] end
    presentation_currency = if Spree::Config[:presentation_currency] then Spree::Config[:presentation_currency] end
    if presentation_currency and settlement_currency
      @rate = Spree::CurrencyRate.find_by(:target_currency => presentation_currency)
      update_presentation_payment_total
      update_presentation_item_total
      update_presentation_shipment_total
      update_presentation_adjustment_total
      update_presentation_total
    end
  end

  def persist_totals
    order.update_columns(
      payment_state: order.payment_state,
      shipment_state: order.shipment_state,
      item_total: order.item_total,
      presentation_item_total: order.presentation_item_total,
      item_count: order.item_count,
      adjustment_total: order.adjustment_total,
      presentation_adjustment_total: order.presentation_adjustment_total,
      included_tax_total: order.included_tax_total,
      presentation_included_tax_total: order.presentation_included_tax_total,
      additional_tax_total: order.additional_tax_total,
      presentation_additional_tax_total: order.presentation_additional_tax_total,
      payment_total: order.payment_total,
      presentation_payment_total: order.presentation_payment_total,
      shipment_total: order.shipment_total,
      presentation_shipment_total: order.presentation_shipment_total,
      total: order.total,
      presentation_total: order.presentation_total,
      updated_at: Time.now,
    )
  end

  def update_presentation_total
    order.presentation_total = @rate.convert_to_won_f(order.total)
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

