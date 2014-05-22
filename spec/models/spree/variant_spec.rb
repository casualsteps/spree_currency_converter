require 'spec_helper'

describe Spree::Variant do
  describe "when creating a variant" do
    Spree::Config[:presentation_currency] = 'KRW'
    let(:variant) { create(:variant) }

    before do
      Spree::CurrencyRate.create(:rate => 1050, :base_currency => 'USD', :target_currency => 'KRW')
    end

    it "should have an additional price in won" do
      expect(variant.prices.length).to eq(2)
      expect(variant.price_in('KRW').amount).to eq(20989.0)
      expect(variant.price_in('KRW').currency).to eq("KRW")
      expect(variant.price_in('USD').amount).to eq(19.99)
      expect(variant.price_in('USD').currency).to eq('USD')
    end

    it "should have only two prices one in won after an update" do
      expect(variant.prices.length).to eq(2)
      expect(variant.price_in('KRW').amount).to eq(20989.0)
      expect(variant.price_in('USD').amount).to eq(19.99)
      expect(variant.prices.length).to eq(2)
      variant.update(price: 200)
      expect(variant.price_in('KRW').amount).to eql(210000.0)
      expect(variant.price).to eql(200.0)
    end
  end
end
