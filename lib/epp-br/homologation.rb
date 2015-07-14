require 'fixtures/domain'
require 'fixtures/contact'
require 'fixtures/organization'

module EPP
  module BR
    class Homologation
      def initialize
        @client = EPP::BR::Client.new
        @server = EPP::BR::Server.new
      end

      def run
        self.connect
        self.hello

        self.contact_create
        # self.contact_info
        # self.contact_update

        # self.organization_check
        self.organization_create
        # self.organization_info

        # self.domain_check
        self.domain_create
        # self.domain_info
        # self.domain_update
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

      def contact_create
        fixture = ContactFixture.info
        create = @client.contact.create 'NONEXISTE', fixture.clone
        @contact_id = create.id
        @contact_pw = fixture[:auth_info][:pw]

        self.out create
      end

      def contact_info
        self.out @client.contact.info @contact_id
      end

      def contact_update
        fixture = ContactFixture.change
        self.out @client.contact.update @contact_id, fixture
      end

      def organization_check
        fixture = OrganizationFixture.info
        self.out @client.organization.check fixture.clone[:brorg][:organization]
      end

      def organization_create
        fixture = OrganizationFixture.info
        create = @client.organization.create 'NONEXISTE', fixture.clone
        @brorg_id = create.id
        @brorg_pw = fixture[:auth_info][:pw]
        @brorg_cnpj = fixture[:brorg][:organization]
        self.out create
      end

      def organization_info
        self.out @client.organization.info @brorg_id
      end

      def domain_check
        self.out @client.domain.check 'domainnonexiste.com.br'
      end

      def domain_create
        create = @client.domain.create(
          DomainFixture.name,
          DomainFixture.info(
            @brorg_cnpj,
            @contact_id,
            @contact_pw
          )
        )
        self.out create
      end

      def domain_info

      end

      def domain_update

      end

      def out command
        constant_names  = command.class.name.split('::')
        entity_name     = constant_names[1]
        command_name    = constant_names[2].gsub(/Response/, '').downcase

        if command.success?
          print "#{entity_name} #{command_name} -> "
        else
          puts "ERROR on #{entity_name} #{command_name}"
          puts command.to_xml
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
