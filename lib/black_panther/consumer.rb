# frozen_string_literal: true

module BlackPanther
  class Consumer
    def initialize(connection)
      @connection = connection
    end

    def subscribe
      queue.subscribe(block: true, manual_ack: true) do |delivery_info, properties, payload|
        yield(Message.new(delivery_info, properties, payload))
      end
    end
    alias run subscribe

    private

    attr_reader :connection

    def queue
      @queue ||= begin
        channel.queue(connection.queue, no_declare: true)
               .bind(exchange, routing_key: routing_key)
      end
    end

    def channel
      @channel ||= connection.call.create_channel
    end

    def exchange
      @exchange ||= channel.topic(connection.exchange, durable: true)
    end

    def routing_key
      @routing_key ||= connection.routing_key
    end
  end
end
