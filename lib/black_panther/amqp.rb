# frozen_string_literal: true

module BlackPanther
  class Amqp
    class ConfigurationFileNotFound < StandardError
      def initialize
        super('config/black_panther.yml file has not been found')
      end
    end

    def initialize(environment = 'development')
      @environment = environment
    end

    def producer
      Producer.new(connection)
    end

    def consumer
      Consumer.new(connection)
    end

    private

    attr_reader :environment

    def configurations
      @configurations ||= load_configurations[environment] || {}
    end

    def connection
      @connection ||= Connection.new(ConnectionString.new(config: configurations))
    end

    def load_configurations
      raise ConfigurationFileNotFound unless File.exist?(path_to_file)

      YAML.load_file(path_to_file)
    end

    def path_to_file
      'config/black_panther.yml'
    end
  end
end
