# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: black_panther/messages/model_group.proto

require 'google/protobuf'

require 'black_panther/messages/model_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "black_panther.messages.ModelGroup" do
    optional :name, :string, 1
    repeated :model, :message, 2, "black_panther.messages.Model"
  end
end

module BlackPanther
  module Messages
    ModelGroup = Google::Protobuf::DescriptorPool.generated_pool.lookup("black_panther.messages.ModelGroup").msgclass
  end
end