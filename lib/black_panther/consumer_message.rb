# frozen_string_literal: true

module BlackPanther
  class Consumer
    class Message
      attr_reader :delivery_info, :properties, :payload, :status

      def initialize(delivery_info, properties, payload)
        @delivery_info = delivery_info
        @properties = properties
        @payload = payload
        @status = :none
      end

      def acknowledge!
        delivery_info.channel.ack(delivery_info.delivery_tag)
        @status = :acknowledged
      end
      alias ack! acknowledge!

      def retry!
        delivery_info.channel.reject(delivery_info.delivery_tag, true)
        @status = :retried
      end

      def discard!
        delivery_info.channel.reject(delivery_info.delivery_tag, false)
        @status = :discarded
      end
    end
  end
end
