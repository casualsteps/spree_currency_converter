Spree::AppConfiguration.class_eval do
  preference :presentation_currency, :string, :default => 'KRW'
end
