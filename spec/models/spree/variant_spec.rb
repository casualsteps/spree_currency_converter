require 'spec_helper'

describe Spree::Variant do
  describe "when creating a variant" do
    let(:variant) { create(:variant) }

    before do
      Spree::CurrencyRate.create(:rate => 1050, :base_currency => 'USD', :target_currency => 'KRW')
    end

    it "should have an additional price in won" do
      expect(variant.prices.length).to eq(2)
      expect(variant.prices.first.amount).to eq(20989.0)
      expect(variant.prices.first.currency).to eq("KRW")
    end

  end
end
