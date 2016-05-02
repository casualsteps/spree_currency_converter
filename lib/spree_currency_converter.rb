require 'spree_core'
require 'spree_currency_converter/engine'

require 'money'
require 'active_support/core_ext'

require 'rest_client'
require 'nokogiri'
require 'open-uri'
require 'date'

class Money
  module Bank
    class KoreaCustomsBank < Money::Bank::VariableExchange

      KR_EXCHANGE_RATE_URL = 'http://www.customs.go.kr/kcshome/rate/ExchangeRateList.do'

      attr_reader :rates_updated_at, :rates_updated_on, :rates_expired_at

      def flush_rates
        @mutex.synchronize{
          @rates = {}
        }
      end

      def update_rates(date = Date.today)
        @mutex.synchronize{
          update_parsed_rates exchange_rates(date)
          @rates_updated_at = Time.now
          @rates_updated_on = date
          update_expired_at
          @rates
        }
      end

      def set_rate(from, to, rate)
        @rates[rate_key_for(from, to)] = rate
        @rates[rate_key_for(to, from)] = 1.0 / rate
      end

      def get_rate from, to
        update_rates if rates_expired?
        @rates[rate_key_for(from, to)] || indirect_rate(from, to)
      end

      def rates_expired?
        !rates_expired_at || rates_expired_at <= Time.now
      end

      def exchange_rates(date)
        { 'USD' => BigDecimal('1,157.13') }
        # page = RestClient.post(KR_EXCHANGE_RATE_URL,{ 'currDate' => date.strftime("%F"), 'eximDitc' => 2, 'x' => 38, 'y' => 10 })
        # Nokogiri::HTML(page).xpath('//*[@id="txt"]/div/table/tbody').css('tr').each_with_object({}) do |row, all|
        #   cols = row.css('td')
        #   all[cols[1].text] = BigDecimal(cols[2].text.tr(',', ''))
        # end
      end

      private

      def update_expired_at
        # next sunday from today
        @rates_expired_at = (7 - Time.now.wday).days.from_now
      end

      def indirect_rate from, to
        from_base_rate = @rates[rate_key_for('KRW', from)]
        to_base_rate = @rates[rate_key_for('KRW', to)]
        to_base_rate / from_base_rate
      end

      def update_parsed_rates rates
        local_currencies = Money::Currency.table.map { |currency| currency.last[:iso_code] }
        add_rate('KRW', 'KRW', 1)
        rates.each do |currency, rate|
          begin
            if local_currencies.include? currency
              add_rate(currency, 'KRW', rate)
              add_rate('KRW', currency, 1 / rate)
            end
          rescue Money::Currency::UnknownCurrency
          end
        end
      end
    end
  end
end
