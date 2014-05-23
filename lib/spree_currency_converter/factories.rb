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

  factory :price_in_krw, parent: :price do
    variant
    amount 300000
    currency 'KRW'
  end

  factory :price_in_usd, parent: :price do
    variant
    amount 200
    currency 'USD'
  end

  factory :multi_currency_variant, parent: :base_variant do
    prices {
      Array[FactoryGirl.create(:price_in_krw),FactoryGirl.create(:price_in_usd)]
    }
  end

  factory :multi_currency_product, parent: :product do
    prices {
      Array[FactorGirl.create(:price_in_krw),FactoryGirl.create(:price_in_usd)]
    }
  end

  factory :multi_currency_product_with_price_diff, parent: :product do
    price 200.00
    variants {
      Array[FactoryGirl.create(:multi_currency_variant)]
    }
  end

  factory :line_item_in_krw, parent: :line_item do
    price :price_in_krw
  end

  factory :line_item_in_usd, parent: :line_item do
    price :price_in_usd
  end

end
