module RockQueue
  class EmailNotifier < AbstractNotifier
    def update(message)
      puts "Sending e-mail message: #{message}"
    end
  end
end