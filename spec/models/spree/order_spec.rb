require 'spec_helper'

describe "when placing an order it should use the USD price" do
  let!(:latest_us_dollar_rate) {create :latest_us_dollar_rate}
  before do
    reset_spree_preferences do |config|
      config[:presentation_currency] = 'KRW'
      config[:settlement_currency] = 'USD'
    end
    create_our_order(:price => 50.00)
  end

  context "with presentation_currency set" do

    it "should create the order in USD but have a KRW price" do
      expect(@order.currency).to eq("USD")
      expect(@order.presentation_currency).to eq("KRW")
    end

    it "should have presentation totals and display totals" do
      expect(@order.item_total).to eq(50.00)
      expect(@order.presentation_item_total).to eq(52500.00)
      expect(@order.display_presentation_item_total).to eq(Spree::Money.new(52500.00, {currency: Spree::Config[:presentation_currency]}))
      expect(@order.presentation_included_tax_total).to eq(0)
      expect(@order.display_presentation_included_tax_total).to eq(Spree::Money.new(0, {currency: Spree::Config[:presentation_currency]}))
      expect(@order.additional_tax_total).to eq(5.0)
      expect(@order.presentation_additional_tax_total).to eq(5250)
      expect(@order.display_presentation_additional_tax_total).to eq(Spree::Money.new(5250, {currency: Spree::Config[:presentation_currency]}))
      expect(@order.shipment_total).to eq(10.0)
      expect(@order.presentation_shipment_total).to eq(10500.0)
      expect(@order.display_presentation_shipment_total).to eq(Spree::Money.new(10500.00, {currency: Spree::Config[:presentation_currency]}))
      expect(@order.presentation_payment_total).to eq(0)
      expect(@order.display_presentation_payment_total).to eq(Spree::Money.new(0,{currency: Spree::Config[:presentation_currency]}))
    end

  end

  def create_our_order(args={})
    params = {}
    @variant = create(:multi_currency_variant)
    params = {variant: @variant}
    params.merge!(quantity: args[:quantity]) if args[:quantity]
    params.merge!(price: args[:price]) if args[:price]
    @line_item = create(:line_item_in_usd, params)
    @order = @line_item.order
    @shipping_method = create(:shipping_method)
    @shipping_method.calculator.preferred_amount = 0.10
    @shipping_method.save
    @shipment = create(:shipment, {number: 1, cost: 10})
    @payment = create(:payment, { amount: 50 } )
    @order.shipments = [@shipment]
    @tax_adjustment = create(:tax_adjustment,{ adjustable: @line_item })
    @order.line_items.reload
    @order.update!
  end

end

