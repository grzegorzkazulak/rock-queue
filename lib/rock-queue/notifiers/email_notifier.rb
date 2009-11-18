module RockQueue
  
  class EmailNotifier < AbstractNotifier
  
    def initialize(config)
      $server_config = config
    end
    
    # Notify by email  
    def update(message)

      begin
        require 'mail'
      rescue
        puts "You need `mail` gem to use the Email Notifier"
        exit
      end
      
      puts "Sending e-mail message: #{message}"

      Mail.defaults do
        smtp do
          host $server_config[:server]
          port $server_config[:port]
          user $server_config[:username]
          pass $server_config[:password] 
        end
        

      end

      Mail.deliver do
          from $server_config[:from]
            to $server_config[:to]
       subject 'Processing error'
          body message.to_s
      end
    end

  end
end