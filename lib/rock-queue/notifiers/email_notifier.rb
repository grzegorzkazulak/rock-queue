module RockQueue
  class EmailNotifier < AbstractNotifier
    def initialize(config)
    
    end
    
    def update(message)
      puts "Sending e-mail message: #{message}"
    end
  end
end