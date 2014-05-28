require 'spec_helper'
module Spree
  describe ProductsHelper do
    include ProductsHelper
    before do
      reset_spree_preferences do |config|
        config.presentation_currency = "KRW"
        config.settlement_currency = "USD"
        config.show_variant_full_price = true
      end
      Spree::CurrencyRate.create(:base_currency => "USD", :target_currency => "KRW", :rate => 1050)
    end

    let(:product) { create :multi_currency_product }
    let(:price_diff_prod) { create :multi_currency_product_with_price_diff }
    let(:price_diff) { create :multi_currency_variant, product: price_diff_prod }
    let(:variant) { create :multi_currency_variant }

    context "variant_price" do
      describe "when the presentation_currency is KRW" do
        it "should return the KRW price" do
          #result is encoded as a html string and the ₩ symbol is converted to
          #this &#x20A9
          expect(variant_price(variant)).to eq("&#x20A9;20,989")
        end
      end

      describe "when the presentation_currency is KRW but currency USD is passed" do
        it "should return the price in USD" do
          expect(variant_price(variant,'USD')).to eq("$200.00")
        end
      end

      describe "when the presentation_currency is KRW and there is a price difference" do
        #price of the product in KRW is 210000.0 and the variant is 20989.0
        #difference works out at 189,011 KRW
        it "should return the price in KRW with the difference" do
          Spree::Config[:show_variant_full_price] = false
          expect(variant_price(price_diff)).to eq("(Subtract): &#x20A9;189,011")
        end
      end
    end
  end
end
