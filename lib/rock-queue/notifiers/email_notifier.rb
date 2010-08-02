begin
  require 'mail'
rescue
  RockQueue.logger.error "You need `mail` gem to use the Email Notifier"
end

module RockQueue
  class EmailNotifier < AbstractNotifier
    def initialize(config)
      $server_config = config
      
      Mail.defaults do
        delivery_method :smtp, {
          :address        => $server_config[:server],
          :port           => $server_config[:port],
          :user_name      => $server_config[:username],
          :password       => $server_config[:password]
        }
      end
    end
    
    # Notify by email  
    def update(error)
      RockQueue.logger.info "Sending e-mail message: #{error.message}"

      Mail.deliver do
          from $server_config[:from]
            to $server_config[:to]
       subject "Processing error - '#{error.message}'"
          body error.backtrace.join("\n")
      end
    end
  end
end
