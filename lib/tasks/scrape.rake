require 'rest_client'
require 'nokogiri'
require 'open-uri'
require 'date'

KR_EXCHANGE_RATE_URL = 'http://www.customs.go.kr/kcshome/rate/ExchangeRateList.do'

namespace :scrape do
  task :scrape_exchange_rate => :environment do
    page = RestClient.post(KR_EXCHANGE_RATE_URL,{ 'currDate' => DateTime.now().strftime("%F"), 'eximDitc' => 2, 'x' => 38, 'y' => 10 })
    doc = Nokogiri::HTML(page)
    rate = nil
    base_currency = doc.xpath('//*[@id="txt"]/div/table/tbody/tr[1]/td[2]').first.content
    rate = doc.xpath('//*[@id="txt"]/div/table/tbody/tr[1]/td[3]').first.content.tr(',','').to_f
    currency_rate = Spree::CurrencyRate.new(:rate => rate.to_f, :base_currency => base_currency)
    currency_rate.save
  end
end
