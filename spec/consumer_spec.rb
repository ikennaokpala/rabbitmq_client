# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BlackPanther::Consumer do
  describe '#subscribe' do
    let(:config) { { queue: 'tusker_queue', routing_key: 'deadpool.message', exchange: 'tusker_exchange' } }
    let(:connection_string) { BlackPanther::ConnectionString.new(config: config) }
    let(:connection) { BlackPanther::Connection.new(connection_string) }
    let(:queue) { instance_double(Bunny::Queue, bind: instance_double(Bunny::Queue, subscribe: nil)) }
    let(:channel) { instance_double(Bunny::Channel, queue: queue, topic: nil) }
    let(:session) { instance_double(Bunny::Session, create_channel: channel) }
    let(:consumer) { described_class.new(connection) }

    before do
      allow(Bunny).to receive(:new) { session }
      allow(session).to receive(:start) { session }
    end

    it 'subcribes to queue' do
      expect(channel).to receive(:queue).with('tusker_queue', no_declare: true)

      consumer.run
    end
  end
end
