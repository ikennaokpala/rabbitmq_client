# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BlackPanther::Producer do
  describe 'sending a message' do
    let(:model) do
      BlackPanther::Messages::Model.new(name: 'CLK 200 Convertible')
    end
    let(:model_group) do
      BlackPanther::Messages::ModelGroup.new(
        name: 'CLK',
        model: [model]
      )
    end
    let(:manufacturer) do
      BlackPanther::Messages::Manufacturer.new(
        name: 'Mercedes-Benz',
        model_group: [model_group]
      )
    end
    let(:message) { manufacturer }
    let(:connection_string) { BlackPanther::ConnectionString.new(config: {}) }
    let(:connection) { BlackPanther::Connection.new(connection_string) }
    let(:exchange) { instance_double(Bunny::Exchange, publish: nil, wait_for_confirms: true) }
    let(:channel) { instance_double(Bunny::Channel, confirm_select: nil, topic: exchange, open?: false) }
    let(:session) { instance_double(Bunny::Session, create_channel: channel) }
    let(:producer) { described_class.new(connection) }

    before do
      allow(Bunny).to receive(:new) { session }
      allow(session).to receive(:start) { session }
    end

    context 'published message' do
      it 'sends message with protobuf representation' do
        expect(exchange).to receive(:publish).with(message.to_proto, hash_including(content_type: 'application/vnd.black_panther.manufacturer+octet-stream'))

        producer.send(message)
      end
    end

    context 'failed message' do
      let(:exchange) { instance_double(Bunny::Exchange, publish: nil, wait_for_confirms: false) }

      it 'raises error when request fails' do
        expect { producer.send(message) }.to raise_error(
          BlackPanther::Producer::ProducingError
        )
      end
    end
  end
end
