require 'spec_helper'
require 'rack/requestash/log4r'
require 'json'

describe Rack::Requestash::Log4r::Formatter do
  subject(:formatter) { described_class.new }

  before :all do
    # Ensure Log4r::LNAMES gets seeded
    Log4r::RootLogger.instance
  end

  describe '#format' do
    let(:logevent) { ::Log4r::LogEvent.new(level, logger, tracer, data) }
    let(:logger) do
      logger = double('RSpec Logger')
      logger.stub(:name => 'rspec')
      logger.stub(:fullname => 'rspec fullname')
      logger
    end
    let(:tracer) { [] }

    subject(:log) { formatter.format(logevent) }

    context 'with an WARN log level' do
      # level 3 is "warn" in log4r
      let(:level) { 3 }
      let(:data) { "rspec log data" }

      it { should be_instance_of String }

      it "should be JSON" do
        expect {
          JSON.parse(log)
        }.not_to raise_error
      end

      context "the JSON log output" do
        subject(:output) { JSON.parse(log) }

        it { should have_key 'type' }
        it { should have_key 'remote_addr' }
        it 'should have "log" as the type' do
          expect(output['type']).to eql('log')
        end
        it { should have_key 'event' }

        context "it's event block" do
          subject(:event) { output['event'] }

          it { should be_instance_of Hash }

          it 'should have the tracer' do
            expect(event['tracer']).to eql(tracer)
          end

          it 'should have the textual log level' do
            expect(event['level']).to eql('WARN')
          end

          it 'should have the "data" from the event as a "message"' do
            expect(event['message']).to eql(data)
          end
        end
      end
    end
  end
end
