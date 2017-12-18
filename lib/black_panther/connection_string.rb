# frozen_string_literal: true

module BlackPanther
  class ConnectionString
    def initialize(url = nil, config: {})
      @url = url
      @config = config.symbolize_keys
    end

    def url
      @url || url_from_options || url_env
    end
    alias to_s url

    def url_env
      ENV['RABBITMQ_URL']
    end

    def url_from_options
      "amqp://#{user}:#{password}@#{host}:#{port}"
    end

    def user
      @config[:user]
    end

    def password
      @config[:password]
    end

    def host
      @config[:host]
    end

    def port
      @config[:port]
    end

    def options
      @config.reject { |key, _value| excempt.include?(key) }
    end

    def exchange
      @config[:exchange]
    end

    def queue
      @config[:queue]
    end

    def routing_key
      @config[:routing_key]
    end

    private

    def excempt
      %i[exchange queue routing_key]
    end
  end
end
