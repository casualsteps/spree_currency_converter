Spree::AppConfiguration.class_eval do
  preference :settlement_currency, :string, :default => 'USD'
  preference :presentation_currency, :string, :default => 'KRW'
end
