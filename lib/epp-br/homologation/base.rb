require 'fixtures/domain'
require 'fixtures/contact'
require 'fixtures/organization'

module EPP
  module BR
    module Homologation
      class Base
        def initialize
          @client = EPP::BR::Client.new
          @server = EPP::BR::Server.new
        end

        def prepare

        end

        def run
          prepare

          self.connect
          self.hello

          self.contact_create
          self.contact_info
          self.contact_update

          self.organization_check
          self.organization_create
          self.organization_info

          self.domain_check
          self.domain_create
          self.domain_info
          self.domain_update
        end

        def connect
          @server.connection do
            puts "Connected to host"
            print "\n"
          end
        end

        # def change_password
        #
        # end

        def hello
          @client.hello
          puts "Hello"
          print "\n"
        end

        def out response
          constant_names  = response.class.name.split('::')
          entity_name     = constant_names[1]
          command_name    = constant_names[2].gsub(/Response/, '').downcase

          if response.success? || response.pending?
            print "#{entity_name} #{command_name} -> "
          else
            puts "ERROR on #{entity_name} #{command_name}"
            puts "ERROR code: #{response.code}"
            puts "ERROR value: #{response.error_value}"
            puts "ERROR reason: #{response.error_reason}"
            puts response.to_xml
          end

          self.poll_message

          print "\n"
        end

        def poll_message
          poll = @client.poll
          puts poll.message

          if poll.msgQ
            @client.ack(poll.msgQ['id'])
            puts "Ackowledged message #{poll.msgQ['id']}"
          end
        end
      end
    end
  end
end
