# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require 'active_support/hash_with_indifferent_access'
require 'active_support/inflector'
require 'erb'

require 'bunny'

module BlackPanther
  autoload :Amqp, 'black_panther/amqp'
  autoload :Connection, 'black_panther/connection'
  autoload :ConnectionString, 'black_panther/connection_string'
  autoload :Consumer, 'black_panther/consumer'
  Consumer.autoload :Message, 'black_panther/consumer_message'
  autoload :Producer, 'black_panther/producer'
  Producer.autoload :Payload, 'black_panther/producer_payload'
  autoload :VERSION, 'black_panther/version'
  autoload :YAML, 'yaml'

  module Messages
    autoload :BodyStyle, 'black_panther/messages/bodystyle_pb'
    autoload :Engine, 'black_panther/messages/engine_pb'
    autoload :FuelGroup, 'black_panther/messages/fuel_group_pb'
    autoload :Manufacturer, 'black_panther/messages/manufacturer_pb'
    autoload :ModelGroup, 'black_panther/messages/model_group_pb'
    autoload :Model, 'black_panther/messages/model_pb'
    autoload :Option, 'black_panther/messages/option_pb'
    autoload :ResidualValue, 'black_panther/messages/residual_value_pb'
    autoload :TransmissionGroup, 'black_panther/messages/transmission_group_pb'
    autoload :Vehicle, 'black_panther/messages/vehicle_pb'
  end
end
