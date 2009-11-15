module RockQueue
  class AdapterNotSupported < RuntimeError; end
  class NoClassError < RuntimeError; end
  class QueueingServerNotRunning < RuntimeError; end
end