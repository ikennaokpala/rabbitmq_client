# frozen_string_literal: true

module BlackPanther
  class Producer
    class ProducingError < StandardError
      def initialize
        super('Producing message failed')
      end
    end

    def initialize(connection)
      @connection = connection
    end

    def send(message, settings = {})
      payload = Payload.new(message, settings, connection.routing_key)
      exchange.publish(payload.message, payload.settings)
      raise ProducingError unless exchange.wait_for_confirms
    ensure
      channel.close if channel.open?
    end

    private

    attr_reader :connection

    def channel
      connection.call
                .create_channel
                .tap(&:confirm_select)
    end

    def exchange
      channel.topic(connection.exchange, passive: true)
    end
  end
end
