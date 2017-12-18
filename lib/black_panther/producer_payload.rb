# frozen_string_literal: true

module BlackPanther
  class Producer
    class Payload
      attr_reader :routing_key

      def initialize(message, settings, routing_key)
        @message = message
        @settings = settings
        @routing_key = routing_key
      end

      def message
        if protobuf?
          @message.to_proto
        elsif json?
          @message.to_json
        else
          @message
        end
      end

      def settings
        derived_default_settings.merge(@settings)
      end

      protected

      def protobuf?
        @message.respond_to?(:to_proto)
      end

      def json?
        @message.respond_to?(:to_json)
      end

      def content_type
        "application/vnd.black_panther.#{message_name}+#{mime_type}"
      end

      def mime_type
        if protobuf?
          'octet-stream'
        elsif json?
          'json'
        else
          'plain'
        end
      end

      def message_name
        @message.class.name.demodulize.underscore
      end

      def derived_default_settings
        {
          event: :message,
          routing_key: routing_key,
          content_type: content_type,
          persistent: false
        }
      end
    end
  end
end
