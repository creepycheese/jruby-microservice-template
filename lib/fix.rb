require_relative 'proto/exchange.pb.rb'
Dir[File.dirname(__FILE__) + '/fix/models/*.rb'].each { |ff| require ff }

module Fix
end
