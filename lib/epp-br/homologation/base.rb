require 'mocks/domain'

module EPP
  module BR
    module Homologation
      class Base
        @@client = EPP::BR::Client.new

        @@contact       = {}
        @@organization  = {}
        @@domain_1      = {}
        @@domain_2      = {}

        config_file = YAML::load_file('config/epp-br/homologation.yml')
        @@config = config_file['epp-br']['homologation']

        def prepare
          EPP::BR::Homologation::Prepare.new
        end

        def contact
          EPP::BR::Homologation::Contact.new
        end

        def organization
          EPP::BR::Homologation::Organization.new
        end

        def domain
          EPP::BR::Homologation::Domain.new
        end

        def run
          prepare
          
          connect
          hello

          contact.create
          contact.info
          contact.update

          organization.check
          organization.create
          organization.info

          # self.domain.check
          # self.domain.create
          # self.domain.info
          # self.domain.update
        end

        def connect
          @server = EPP::BR::Server.new
          @server.connection do
            puts "Connected to host"
            print "\n"
          end
        end

        # def change_password
        #
        # end

        def hello
          @@client.hello
          puts "Hello"
          print "\n"
        end

        def out response
          constant_names  = response.class.name.split('::')
          entity_name     = constant_names[1]
          command_name    = constant_names[2].gsub(/Response/, '').downcase

          puts response.to_xml

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
          poll = @@client.poll
          puts poll.message

          if poll.msgQ
            @@client.ack(poll.msgQ['id'])
            puts "Ackowledged message #{poll.msgQ['id']}"
          end
        end
      end
    end
  end
end
