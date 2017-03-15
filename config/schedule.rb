set :output, { error: 'log/cron_error.log', standard: 'log/cron_standard.log'}
every 1.week, at: '2:00 am' do
  rake '-s sitemap:refresh'
end