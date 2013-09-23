require 'rack/commonlogger'
require 'json'

module Rack
  module Requestash
    class CommonJsonLogger < Rack::CommonLogger
      def initialize(app, logger=nil)
        super(app, logger)
      end

      def log(env, status, header, began_at)
        #Access the base class variables with caution; they may not exist
        logger = @logger || env['rack.errors']

        blob = {
          :length => header['Content-Length'] || 0,
          :code => status.to_s[0 .. 3],
          :version => env['HTTP_VERSION'],
          :method => env['REQUEST_METHOD'],
          :duration => (Time.now - began_at),
          :query => env["QUERY_STRING"],
          :path => env['PATH_INFO'],
          :remote_addr => env['REMOTE_ADDR'],
          :user => env['REMOTE_USER'],
          :user_agent => env['HTTP_USER_AGENT'],
          :timestamp => Time.now.utc.iso8601
        }

        # If there's an X-Forwarded-For header split it up into a
        # list of machine-readable IPs.
        blob[:forwarded_for] = env['HTTP_X_FORWARDED_FOR'].split(',') if env['HTTP_X_FORWARDED_FOR']

        if logger
          logger.write({:type => 'request',
                        :event => blob}.to_json)
          logger.write("\n")
        end
      end
    end
  end
end
