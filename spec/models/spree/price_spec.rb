require 'spec_helper'

describe Spree::Price do
  describe "when getting a product's price in won" do
    let(:price) { create(:price) }
    let(:variant) { create(:variant) }

    before do
      Spree::CurrencyRate.create(:rate => 1050, :base_currency => 'USD', :target_currency => 'KRW')
    end
    it "should return the products price in won" do
      price_in_won = price.price_in_won
      expect(price_in_won).to eql Money::Money.new(20989,'KRW')
    end
    it "should return the products price as a string" do
      price_in_won_s = price.price_in_won_s
      expect(price_in_won_s).to eql '20989'
    end
  end
end
