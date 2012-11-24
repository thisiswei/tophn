require 'collecting_showhn.rb'

task :showhn => :environment do
  Showhn.perform
end
