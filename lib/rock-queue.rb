$:.unshift File.expand_path(File.dirname(__FILE__))
require 'logger'

module RockQueue
  autoload :Config,                   'rock-queue/config'
  autoload :AbstractNotifier,         'rock-queue/notifiers/abstract_notifier'
  autoload :Notifiers,                'rock-queue/notifiers'
  autoload :EmailNotifier,            'rock-queue/notifiers/email_notifier'
  
  autoload :Worker,                   'rock-queue/worker'
  autoload :QueueObject,              'rock-queue/queue_object'
  
  # Adapters
  autoload :Beanstalkd,               'rock-queue/adapters/beanstalkd'
  autoload :ResqueQueue,              'rock-queue/adapters/resque'
  autoload :DelayedJob,               'rock-queue/adapters/delayed_job'
  
  autoload :AdapterNotSupported,      'rock-queue/errors'
  autoload :NoClassError,             'rock-queue/errors'
  autoload :QueueingServerNotRunning, 'rock-queue/errors'
  autoload :ActiveRecordHelper,       'rock-queue/active_record_helper'
  
  extend self

  # setup a connection
  # options: adapter, server, port, log
  def setup(options)
    case options[:adapter]
    when :beanstalkd
      @adapter = Beanstalkd.new(options)
    when :resque
      @adapter = ResqueQueue.new(options)
    when :delayed_job
      @adapter = DelayedJob.new(options)
    else
      raise ArgumentError
    end
    @logger = Logger.new(options[:log].nil? ? STDOUT : options[:log])
  end

  # return current connection
  def adapter
    if @adapter
      @adapter
    else
      raise RuntimeError, "RockQueue is not connectet. Use setup"
    end
  end

  def push(value, *args)
    adapter.push(value, args)
  end

  def logger
    @logger
  end

  # Pulls the data off the queue. There are two ways to do so:
  # - Call receive with no block (gets you a single item)
  # - Pass a block to it (creates and endles loop that constantly pulls
  #   items from the queue as they become available)
  # All calls to the queueing server are made through the previosuly
  # selecte adaper.
  def receive
    if block_given?
      obj, args = @adapter.pop
      yield QueueObject.new(obj, args) if obj
    else
      raise 'No block given'
    end
  end

  # Register worker for web interface
  def register_worker(worker)
    @adapter.register_worker(worker) if @adapter.respond_to?(:register_worker)
  end

  # Calling adapter method
  def method_missing(sym, *args, &block)
    @adapter.send sym, *args, &block
  end
end
