module SpreeCurrencyConverter
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_currency_converter'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    require 'spree/core/currency_helpers'

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      ActiveSupport.on_load(:action_view) do
        ActionView::Base.send :include, Spree::CurrencyHelpers
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
