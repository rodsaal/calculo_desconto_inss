set :output, "log/cron.log"
env :PATH, ENV['PATH']

every 1.day, at: '4:00 am' do
  runner "UpdateInssDiscountJob.perform_later", environment: 'development'
end
