module RockQueue
  
  class EmailNotifier < AbstractNotifier
  
    def initialize(config)
      $server_config = config
    end
    
    # Notify by email  
    def update(error)

      begin
        require 'mail'
      rescue
        RockQueue::Base.logger.error "You need `mail` gem to use the Email Notifier"
      end
      
      RockQueue::Base.logger.info "Sending e-mail message: #{error.message}"

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
       subject "Processing error - '#{error.message}''"
          body error.backtrace.join("\n")
      end
      
    end

  end
end