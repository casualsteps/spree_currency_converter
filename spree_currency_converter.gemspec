# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_currency_converter'
  s.version     = '2.2.1'
  s.summary     = 'Adds very very basic currency conversion'
  s.description = 'Adds to_won and to_won_s methods to Spree::Price'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Kenley Tomlin'
  s.email     = 'kenleytomlin@gmail.com'
  s.homepage  = 'https://github.com/casualsteps/spree_currency_converter'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.2.1'
  s.add_dependency 'nokogiri', '~> 1.6.1'
  s.add_dependency 'rest_client', '~> 1.7.3'
  s.add_dependency 'money', '~> 6.0.1'
  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
