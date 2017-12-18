# frozen_string_literal: true

module BlackPanther
  class Connection
    attr_reader :exchange

    delegate :url, :options, :queue, :routing_key, to: :@connection_string

    def initialize(connection_string)
      @connection_string = connection_string
      @exchange = connection_string.exchange
      @mutex = Mutex.new
    end

    def call
      @mutex.synchronize do
        @bunny ||= Bunny.new(url, options)
        @bunny.start
      end
    end
  end
end
