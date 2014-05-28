require 'spec_helper'

describe 'when the presentation_currency is KRW' do
  let!(:latest_us_dollar_rate) { create(:latest_us_dollar_rate) }
  let(:line_item) { create(:line_item) }
  before do
    reset_spree_preferences do |config|
      config[:presentation_currency] = 'KRW'
      config[:settlement_currency] = 'USD'
    end
  end
  it 'should return line_item.presentation_single_money in KRW' do
    expect(line_item.presentation_single_money.to_html).to eq("&#x20A9;10,500")
  end
end
