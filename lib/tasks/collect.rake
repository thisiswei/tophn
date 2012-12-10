require 'collect'

task :collect => :environment do
  Collect.perform
end
