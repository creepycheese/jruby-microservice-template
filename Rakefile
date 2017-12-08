require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end
task :default => :test

namespace :proto do
  desc 'Компиляция протобафов'

  task :compile do
    ENV['PB_NO_TAG_WARNINGS'] = '1'

    %w().each do |package|
      ::Rake::Task['protobuf:compile'].invoke(package, "./proto ./proto/#{package}.proto", './lib/proto', 'ruby', '._pb.rb')
      File.rename("./lib/proto/#{package}.pb.rb", "./lib/proto/#{package}_pb.rb")
      ::Rake::Task['protobuf:compile'].reenable
    end
  end
end
