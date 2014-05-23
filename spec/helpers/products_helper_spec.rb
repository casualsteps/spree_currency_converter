require 'spec_helper'
module Spree
  describe ProductsHelper do
    include ProductsHelper
    before do
      reset_spree_preferences do |config|
        config.presentation_currency = "KRW"
        config.settlement_currency = "USD"
      end
      Spree::CurrencyRate.create(:base_currency => "USD", :target_currency => "KRW", :rate => 1050)
    end
    let(:product) { create :multi_currency_product }
    let(:variant) { create :multi_currency_variant }

    context "variant_price" do
      describe "when the presentation_currency is KRW" do
        it "should return the KRW price" do
          expect(variant_price(variant)).to eq("300000")
        end
      end

      describe "when the presentation_currency is KRW but currency USD is passed" do
        it "should return the price in USD" do
          expect(variant_price(variant)).to eq("200")
        end
      end
    end

  end
end
