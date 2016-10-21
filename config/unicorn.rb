root = '/home/pdfr14/web/pdf'
working_directory root
pid '/home/pdfr14/web/pdf/tmp/pids/unicorn.pid'
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

worker_processes 4
timeout 180

environment = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'

# Save on RAM while in development
if environment == 'development'
  worker_processes 2
  #listen '172.31.22.5:3000'
elsif environment == 'production'
  listen '192.169.165.161:3000'
  worker_processes 2
end

#timeout 60
preload_app true
#@delayed_job_pid = nil
before_fork do |server, worker|
  # Close all open connections
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
  #@delayed_job_pid ||= spawn('scripts/delayed_job stop ; scripts/delayed_job start')
end

after_fork do |server, worker|
  # Reopen all connections
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
