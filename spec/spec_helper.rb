$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require 'webmock/rspec'
require 'recycle_scraper'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

def ensure_scraper_credentials!
  return if ENV.key?('SCRAPER_USERNAME') && ENV.key?('SCRAPER_PASSWORD')
  fail 'Please provide scraper credentials by exporting ' \
       'SCRAPER_USERNAME & SCRAPER_PASSWORD'
end
