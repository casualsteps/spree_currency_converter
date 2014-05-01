FactoryGirl.define do
  factory :latest_us_dollar_rate, class: Spree::CurrencyRate do
    base_currency "USD"
    target_currency "KRW"
    rate 1050.0000
    updated_at "2014-04-30 12:00:00"
    created_at "2014-04-30 12:00:00"
  end
  factory :out_of_date_us_dollar_rate, class: Spree::CurrencyRate do
    base_currency "USD"
    target_currency "KRW"
    rate 1075.0000
    updated_at "2014-04-29 12:00:00"
    created_at "2014-04-29 12:00:00"
  end
  factory :british_pounds, class: Spree::CurrencyRate do
    base_currency "GBP"
    target_currency "KRW"
    rate 2000.0000
    updated_at "2014-04-30 12:00:00"
    created_at "2014-04-30 12:00:00"
  end
end
