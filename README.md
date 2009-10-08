Rock Queue
=====

Rock Queue is a simple, yet powerful unified interface for various messaging queues.

Installation
----------

You can obtain this gem from one of those sources:

* **Github**: gem install grzegorzkazulak-rock-queue --source=http://gems.github.com
* **Gemcutter**: gem install rock-queue --source=http://http://gems.gemcutter.com
* **Rubyforge**: gem install rock-queue

If you are on Mac or linux (are there people still using windows :-) ?) you will need sudo privileges to run those commands.

How to use
----------

Below you will find example how to setup Rock Queue. It's really straight-forward but please note that adapter
is always passed as a symbol

### Setup

	require 'rubygems'
	require 'rock-queue'
	
	rq = RockQueue::Base.new :beanstalkd

And that's it. You are ready to roll.

### Storing objects

	require 'rubygems'
	require 'rock-queue'

	rq = RockQueue::Base.new :beanstalkd
	rq.put("Test item")
	
### Retrieving objects

	require 'rubygems'
	require 'rock-queue'

	rq = RockQueue::Base.new :beanstalkd
	rq.receive do |queue|
		puts queue.item
	end
	
### Credits

Grzegorz Kazulak <grzegorz.kazulak@gmail.com>