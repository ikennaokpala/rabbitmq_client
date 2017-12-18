# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BlackPanther::Consumer::Message do
  let(:channel) { instance_double(Bunny::Channel) }
  let(:delivery_info) { instance_double(Bunny::DeliveryInfo, channel: channel, delivery_tag: :some_tag) }
  let(:properties) { instance_double(Bunny::MessageProperties) }
  let(:payload) { BlackPanther::Messages::Manufacturer.new(name: 'Mercedes-Benz').to_proto }
  let(:message) { described_class.new(delivery_info, properties, payload) }

  it 'ack sends an ack to the channel' do
    expect(channel).to receive(:ack).with(:some_tag)

    message.acknowledge!

    expect(message.status).to eql(:acknowledged)
  end

  it 'retry sends a reject to the channel with requeue set' do
    expect(channel).to receive(:reject).with(:some_tag, true)

    message.retry!

    expect(message.status).to eql(:retried)
  end

  it 'reject sends a reject to the channel without requeue set' do
    expect(channel).to receive(:reject).with(:some_tag, false)

    message.discard!

    expect(message.status).to eql(:discarded)
  end
end
