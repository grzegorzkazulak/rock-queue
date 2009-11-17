require 'rock-queue'

namespace :rock_queue do
  desc "Start a Rock Queue worker"
  task :work do
    worker = RockQueue::Worker.new
    worker.verbose = ENV['VERBOSE']
    puts "=> Rock-queue worker initialized (#{worker})"
    worker.work
  end
end