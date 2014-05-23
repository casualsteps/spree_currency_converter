require 'spec_helper'

module Spree
  describe BaseHelper do
    include BaseHelper
    before do
      reset_spree_preferences do |config|
        config.presentation_currency = "KRW"
        config.settlement_currency = "USD"
      end
      Spree::CurrencyRate.create(:base_currency => "USD", :target_currency => "KRW", :rate => 1050)
    end

    let(:product) { create :multi_currency_product }
    let(:variant) { create :multi_currency_variant }

    context "display_price" do
      describe "when the presentation_currency is KRW" do
        it "should return the KRW price for the product" do
          expect(display_price(product)).to eq("&#x20A9;210,000")
        end
      end

      describe "when the presentation_currency is KRW but USD is passed" do
        it "should return the USD price for the product" do
          expect(display_price(product,'USD')).to eq("$200.00")
        end
      end
     #TODO functionality for other types of currency conversions not just USD
      #--> KRW 
    end
  end
end
