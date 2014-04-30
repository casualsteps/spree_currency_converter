require 'spec_helper'

describe Spree::CurrencyRate do
  describe "when creating a CurrencyRate" do
    it "should be invalid when there is no rate" do
      currencyRate = Spree::CurrencyRate.new(base_currency: 'USD', target_currency: 'KRW')
      expect(currencyRate.invalid?).to eql true
    end

    it "should default to 'USD' when there is no base_currency" do
      currencyRate = Spree::CurrencyRate.new(rate: 1040.5000, target_currency: 'KRW')
      expect(currencyRate.invalid?).to eql false
      expect(currencyRate.base_currency).to eql 'USD'
    end

    it "should default to 'KRW' invalid when there is no target_currency" do
      currencyRate = Spree::CurrencyRate.new(rate: 1040.5000, base_currency: 'USD')
      expect(currencyRate.invalid?).to eql false
      expect(currencyRate.target_currency).to eql 'KRW'
    end

    it  "should create a currency rate when all required values are passed" do
      currencyRate = Spree::CurrencyRate.new(rate: 1040.5000, base_currency: 'USD', target_currency: 'KRW')
      expect(currencyRate.invalid?).to eql false
      expect(currencyRate.base_currency).to eql 'USD'
      expect(currencyRate.target_currency).to eql 'KRW'
      expect(currencyRate.rate).to eql 1040.5000
    end
  end

  describe "when calculating a currency conversion based on a rate" do
    let(:latest_us_dollar_rate) { create(:latest_us_dollar_rate) }
    let(:out_of_date_us_dollar_rate) { create(:out_of_date_us_dollar_rate) }

    it 'should calculate the price in korean won' do
      price_in_won = latest_us_dollar_rate.convert_to_won 10000
      expect(price_in_won).to eql 9.52
    end
  end
end
