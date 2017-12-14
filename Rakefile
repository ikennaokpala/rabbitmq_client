# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

load 'protobuf/tasks/compile.rake'

namespace :black_panther do
  desc 'Compile protobuf definitions with black_panther default'
  task :compile do
    Rake::Task['protobuf:compile'].invoke('black_panther', 'definitions', 'lib', 'ruby')
  end
end
