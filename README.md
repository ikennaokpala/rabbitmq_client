# BlackPanther

Welcome Black Panther gem!. This gem provides classes and methods for transferring structured google `protobuf` messages through a message queue.

## Installation

To get started install `protobuf`:

    $ brew install protobuf

To install simply run:

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install black_panther

To include in your rails or ruby project, add the following line to your Gemfile.

```ruby
gem 'black_panther', git: 'https://github.com/tusker-direct/black_panther'
```

## Usage

To compile `protobuf` files run:

    $ bundle exec rake black_panther:compile
