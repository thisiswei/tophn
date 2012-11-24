require 'ping.rb'

task :ping => :environment do 
  Ping.perform
end
