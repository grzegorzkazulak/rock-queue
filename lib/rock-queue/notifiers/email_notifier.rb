module RockQueue
  class EmailNotifier < AbstractNotifier
    def initialize(config)
    
    end
    
    def update(message)
      puts "Sending e-mail message: #{message}"
      Net::SMTP.start('localhost') do |smtp|
        smtp.send_message msg, from, to
      end
    end

  end
end