# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BlackPanther::Connection do
  context 'runtime mode' do
    let(:url) { 'amqp://guest:guest@rabbitmq.tusker.com:5672' }
    let(:exchange_name) { 'tusker_exchange' }
    let(:config) do
      {
        host: 'rabbitmq.tusker.com',
        port: 5672,
        user: 'guest',
        password: 'guest',
        routing_key: 'deadpool.message',
        queue: 'tusker_queue',
        exchange: exchange,
        recover_from_connection_close: true
      }
    end
    let(:options) { config.reject { |key, _value| %i[exchange queue routing_key].include?(key) } }
    let(:connection_string) { BlackPanther::ConnectionString.new(config: config) }
    let(:connection) { described_class.new(connection_string) }
    let(:exchange) { instance_double(Bunny::Exchange, publish: nil, wait_for_confirms: true) }
    let(:channel) { instance_double(Bunny::Channel, confirm_select: nil, topic: exchange, open?: false) }
    let(:session) { instance_double(Bunny::Session, create_channel: channel) }

    before do
      allow(Bunny).to receive(:new) { session }
      allow(session).to receive(:start) { session }
    end

    describe 'setting up amqp connection' do
      it 'connects to rabbitmq using the given connection options' do
        expect(Bunny).to receive(:new).with(url, options).and_return(session)
        expect(session).to receive(:start)

        connection.call
      end
    end
  end
end
