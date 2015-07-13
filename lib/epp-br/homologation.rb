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
        self.contact_info
        self.contact_update
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
        require 'fixtures/contact'

        fixture = ContactFixture.info
        create = @client.contact.create 'NONEXISTE', fixture.clone
        @contact_id = create.id

        self.out create
      end

      def contact_info
        self.out @client.contact.info @contact_id
      end

      def contact_update
        fixture = ContactFixture.change
        self.out @client.contact.update @contact_id, fixture
      end

      def out command
        constant_names  = command.class.name.split('::')
        entity_name     = constant_names[1]
        command_name    = constant_names[2].gsub(/Response/, '').downcase

        if command.success?
          print "#{entity_name} #{command_name} -> "
        else
          puts "ERROR on #{entity_name} #{command_name}"
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
