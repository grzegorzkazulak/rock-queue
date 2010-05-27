require 'rock-queue'

# Fixme: This is bad, really bad =)
RAILS_ROOT = '' unless defined?(RAILS_ROOT)

namespace :rock_queue do
  desc "Start a Rock Queue worker"

  file_path = "#{RAILS_ROOT}/tmp/pids/rock-queue.pid"

  task :work do
    worker = RockQueue::Worker.new(env["QUEUES"])
    worker.verbose = ENV['VERBOSE']
    RockQueue.logger.info "=> Rock-queue worker initialized (#{worker})"
    pid = fork do
      File.open(file_path, "wb") { |f| f.write(Process.pid) }
      worker.work
    end
  end

  desc "Stop a Rock Queue worker"
  task :stop do
    fork do
      if File.exists?(file_path)
        File.open(file_path, "r") do |f|
          pid = f.readline
          Process.kill('TERM', pid.to_i)
        end
        File.unlink(file_path)
        puts "Rock-Queue shutdown successfully."
      else
        puts "Rock-Queue is not running.I haven't done anything."
      end
    end
  end
end
