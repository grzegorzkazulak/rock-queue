require 'mail'

module RockQueue
  
  class EmailNotifier < AbstractNotifier
  
    def initialize(config)
      @config = config
    end
    
    # Notify by email  
    def update(message)
      puts "Sending e-mail message: #{message}"

      Mail.defaults do
        smtp @config[:server], @config[:port]
        user @config[:username]
        pass @config[:password]
      end

      Mail.deliver do
          from @config[:from]
            to @config[:to]
       subject 'Processing error'
          body message
      end
    end

  end
end