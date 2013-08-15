# Rack::Requestash

Simple Rack "middleware" for generating [logstash](http://logstash.net/)
friendly request access logs for any Rack-based application.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-requestash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-requestash

## Usage

Rack::Requestash will monkey-patch the `Rack::CommonLogger` class which
provides Apache-style access logs. In order to enable in in your application,
try something like:


    require 'rack/requestash'

    class MyServer < Sintara::Base
      Rack::Requestash.install

      get '/' do
       'Yahtzee!'
      end
    end


You will then get nice, JSON formatted logs:


    {"length":"2818","code":"200","version":"HTTP/1.1","method":"GET","duration":0.280802331,"query":"","path":"/","ip":"127.0.0.1","user":null,"timestamp":"2013-08-15T05:49:00Z"}
    {"length":0,"code":"304","version":"HTTP/1.1","method":"GET","duration":0.035969114,"query":"","path":"/javascripts/vendor.js","ip":"127.0.0.1","user":null,"timestamp":"2013-08-15T05:49:00Z"}
    {"length":0,"code":"304","version":"HTTP/1.1","method":"GET","duration":0.069988507,"query":"","path":"/javascripts/i18n/en.js","ip":"127.0.0.1","user":null,"timestamp":"2013-08-15T05:49:00Z"}


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
