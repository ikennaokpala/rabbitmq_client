# frozen_string_literal: true

require 'spec_helper'
require 'rake'

RSpec.describe BlackPanther do
  it 'has a version number' do
    expect(BlackPanther::VERSION).not_to be nil
  end

  it 'compiles protobuf files to ruby equivalents' do
    allow($stdout).to receive(:write)
    allow($stderr).to receive(:write)

    load 'Rakefile'

    expect { Rake::Task['black_panther:compile'].invoke }.not_to output.to_stderr_from_any_process
  end
end
