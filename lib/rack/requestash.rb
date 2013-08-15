require 'rack/requestash/version'
require 'rack/commonlogger'
require 'json'

module Rack
  module Requestash
    # Install the Rack::CommonLogger monkeypatch
    def self.install
      Rack::CommonLogger.class_eval do

        alias_method :original_log, :log

        def log(env, status, header, began_at)
          logger = @logger || env['rack.errors']

          blob = {
            :length => header['Content-Length'] || 0,
            :code => status.to_s[0 .. 3],
            :version => env['HTTP_VERSION'],
            :method => env['REQUEST_METHOD'],
            :duration => (Time.now - began_at),
            :query => env["QUERY_STRING"],
            :path => env['PATH_INFO'],
            :ip => env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_ADDR'],
            :user => env['REMOTE_USER'],
            :timestamp => Time.now.utc.iso8601
          }

          if logger
            logger.write(blob.to_json)
            logger.write("\n")
          end
        end
      end
    end
  end
end
