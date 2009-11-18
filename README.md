Rock Queue
=====

Rock Queue is a simple, yet powerful unified interface for various messaging queues. In other words it allows you to swap your queuing back-end without making any modification to your application except changing the configuration parameters.

Installation
----------

You can obtain this gem from one of those sources:

* **Gemcutter**: gem install rock-queue --source=http://http://gems.gemcutter.com
* **Rubyforge**: gem install rock-queue

If you are on Mac or linux (are there people still using windows :-) ?) you will need sudo privileges to run those commands.

How to use
----------

Below you will find example how to setup Rock Queue. It's really straight-forward but please note that adapter
is always passed as a symbol

### Setup (Rails application)

In your config/initializers folder create a file rock_queue.rb and put following code into it.

	require 'rock-queue'
	RockQueue::Config.settings do |config|
		config.adapter = :resque
		config.host = "192.168.0.1"
		config.port = 6379
	end

And that's it. You are ready to put your objects onto the queue.

### Storing objects (ActiveRecord)

	require 'rubygems'
	require 'rock-queue'

	# Set your settings here (like in the first example)
	
	class Person << ActiveRecord::Base
		include RockQueue::ActiveRecordHelper
	
		def test
			sleep(10)
		end
	end
	
	person = Person.find(1)
	person.async(:test)
	

Following code will let you call the `test` method asynchronously. In other words will put it onto the queue and let your worker(s) do the job. 
You can perform async on any AR object just by passing the actual method name as a symbol.
	
### Retrieving objects by hand

	require 'rubygems'
	require 'rock-queue'
	
	# Set your settings here (like in the first example)

	config = RockQueue::Config.settings
	@queue = RockQueue::Base.new config.adapter, {
				:server => config.host, 
				:port   => config.port
	}  
	
	@queue.receive do |item|
		# Do any operation on the retreived item
		p item
	end
	
Because of the fact that receive method in decoupled from the actual worker code you can easily come up with different worker implementation.
	
### Setting up workers (Rails Application)

To setup a worker you have to require following code in your Rakefile

	require 'rock-queue'
	require 'rock-queue/tasks'

Then just run:

	rake environment rock_queue:work

### Notifications.
	
Rock-queue allows you to register endless number of notifiers using simple DSL which looks like this.

	RockQueue::Config.settings do |config|
		config.adapter = :resque
		config.host = "192.168.0.1"
		config.port = 6379
	
	  config.notifiers do |n|
	    n.register RockQueue::EmailNotifier.new(
	      :server   => 'smtp.gmail.com', 
	      :port     => 465, 
	      :username => 'youraccount',
	      :password => 'yourpassword',
	      :from     => 'youraccount@gmail.com',
	      :to       => 'recipient@example.com'
	    )
	  end
	end
	
`register` takes an instance of your notifications mechanism. Every notifiaction class must contain only two methods: initialize and update.
First one for configuration purposes and the second one that actually performs the process of sending a notification.

### Web Interface
	
TODO	

### Failure handling
	
The worker will retry try to run the job again number of times (3 by default, but it is configurable).
In the event of a last allowed failure worker will pass the exception information to all registered notifiers.

RockQueue ships with email notifier. 
*Important* If you are using an adapter for queueing library that provides similar mechanism consider disabling it. Otherwise you will most likely receive multiple notifications about the same error.

	
### Credits

- Grzegorz Kazulak <grzegorz.kazulak@gmail.com>
- Daniel Chruściak <daniel.chrusciak@dnc.pl>