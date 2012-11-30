require 'collecting_showhn.rb'

task :showhn => :environment do
  Collect.perform
end
