$VERBOSE=nil
ENV['ENVIRONMENT'] = 'test'
require_relative '../config/setup'
require 'minitest/autorun'

DatabaseCleaner.strategy = :transaction

class MiniTest::Test
  def around(&block)
    DatabaseCleaner.cleaning(&block)
  end
end
