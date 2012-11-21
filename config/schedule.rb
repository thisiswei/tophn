set :output, "#{path}/log/cron.log"

every 3.hours do
  rake "update"
end

every :reboot do 
  rake 'update'
end
