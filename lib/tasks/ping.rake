require 'ping'

task :ping => :environment do 
  Ping.perform
end
