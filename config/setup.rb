ENVIRONMENT = ENV['ENVIRONMENT'] || 'development'
ENV['RUBY_ENV'] = ENVIRONMENT

require 'bundler/setup'
require 'yaml'

Bundler.require(ENVIRONMENT.to_sym, :default)
Dir["./jars/lib/\*.jar"].each { |jar| require jar }

lib_path = File.expand_path '../../lib', __FILE__
jars_path = File.expand_path '../../jars/lib', __FILE__
$LOAD_PATH.unshift jars_path
$LOAD_PATH.unshift lib_path

settings_file = File.expand_path '../settings.yml', __FILE__
database_settings = File.expand_path '../database.yml', __FILE__
rabbit_settings = File.expand_path '../rabbitmq.yml', __FILE__

Jdbc::Postgres.load_driver

SETTINGS = YAML.load_file(settings_file)[ENVIRONMENT]

DB_SETTINGS = YAML.load_file(database_settings)[ENVIRONMENT] || {
  'host'     => ENV['DB_HOST'],
  'port'     => ENV['DB_PORT'],
  'password' => ENV['DB_PASSWORD'],
  'user'     => ENV['DB_USER'],
  'database' => ENV['DB_NAME']
}

RABBIT_SETTINGS = YAML.load_file(rabbit_settings)[ENVIRONMENT] || {
  'host'     => ENV['RABBIT_HOST'],
  'port'     => ENV['RABBIT_PORT'],
  'password' => ENV['RABBIT_PASSWORD'],
  'user'     => ENV['RABBIT_USER']
}

ENV['DATABASE_URL'] ||= "jdbc:postgresql://#{DB_SETTINGS['host']}:#{DB_SETTINGS['port']}/#{DB_SETTINGS['database']}?user=#{DB_SETTINGS['user']}&password=#{DB_SETTINGS['password']}"

STDOUT.puts("Running in #{ENVIRONMENT} environment")

DATABASE = Sequel.connect(ENV['DATABASE_URL'], max_connections: 20, test: true, timeout: 10, connect_timeout: 10, read_timeut: 10)
