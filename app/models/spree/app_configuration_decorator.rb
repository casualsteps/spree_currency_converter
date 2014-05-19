Spree::AppConfiguration.class_eval do
  preference :secondary_currency, :string, :default => 'KRW'
end
