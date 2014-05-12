require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear!

require 'factory_girl'
require 'reuters'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end