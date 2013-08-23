require 'log4r'
require 'json'

module Rack
  module Requestash
    module Log4r
      class Formatter < ::Log4r::Formatter
        # Generate a JSON formatted log message, e.g.
        #
        #   {"type":"log","event":{"level":"WARN","tracer":[stacktrace],
        #   "message":"logmessage"}}
        #
        # @param [Log4::LogEvent] event
        # @return [String] JSOn encoded output
        def format(event)
          {
            :type => 'log',
            :event => {
              :tracer => event.tracer,
              :level => ::Log4r::LNAMES[event.level],
              :message => event.data
            }
          }.to_json + "\n"
        end
      end
    end
  end
end
