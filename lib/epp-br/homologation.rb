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

      def contact_create
        fixture = ContactFixture.info
        create = @client.contact.create 'NONEXISTE', fixture.clone
        @contact_id = create.id
        @contact_pw = fixture[:auth_info][:pw]

        out create
      end

      def contact_info
        out @client.contact.info @contact_id
      end

      def contact_update
        fixture = ContactFixture.change

        out @client.contact.update @contact_id, fixture
      end

      def organization_check
        fixture = OrganizationFixture.info

        out @client.organization.check fixture.clone[:brorg][:organization]
      end

      def organization_create
        fixture = OrganizationFixture.info({
          brorg: {
            organization: '13.263.349/0001-68',
            contact:      @contact_id,
            responsible:  "Drunk driver"
          }
        })

        create = @client.organization.create 'NONEXISTE', fixture.clone

        @brorg_id   = create.id
        @brorg_pw   = fixture[:auth_info][:pw]
        @brorg_cnpj = fixture[:brorg][:organization]

        out create
      end

      def organization_info
        out @client.organization.info @brorg_id, @brorg_cnpj
      end

      def domain_check
        @domain_name = 'uw3.com.br' #DomainFixture.name
        out @client.domain.check @domain_name
      end

      def domain_create
        fixture = DomainFixture.info({
          brorg: @brorg_cnpj,
          registrant: @contact_id,
          nameservers: [
            {
              name: "c.sec.dns.br.",
              ipv4: '200.189.40.11'
            },
            {
              name: "a.sec.dns.br.",
              ipv4: '200.160.0.11',
              ipv6: '2001:12ff::11'
            }
          ],
          auth_info: {
            pw: @contact_pw
          }
        })

        create = @client.domain.create(@domain_name, fixture.clone)

        @domain_ticket  = create.ticket
        @domain_ns1     = fixture[:nameservers][0][:name]
        @domain_ns2     = fixture[:nameservers][1][:name]

        out create
      end

      def domain_info
        info = @client.domain.info @domain_name, @domain_ticket

        out info
      end

      def domain_update
        is_domain_created? @domain_name, @domain_ticket

        fixture = DomainFixture.add_rem_ns(
          [
            {name: @domain_ns1},
            {name: @domain_ns2}
          ],
          [
            {name: 'a.sec.dns.br.'},
            {name: 'c.sec.dns.br.'}
          ]
        )

        update = @client.domain.update @domain_name, fixture.clone

        out update
      end

      def domain_create_again

      end

      def poll

      end

      def poll_ack

      end

      def organization_update

      end

      def organization_info_again

      end

      def domain_info_again

      end

      def domain_renew

      end

      def domain_renewed_update

      end

      def domain_delete

      end

      def is_domain_created? name, ticket, minutes = 1
        info = @client.domain.info name, ticket

        unless info.status.include? 'ok'
          print_minutes = minutes > 1 ? 'minutes': 'minute'
          puts "WAITING #{minutes} #{print_minutes} for #{name} creation. Current status: #{info.status}"
          puts info.to_xml
          sleep(60)

          is_domain_created? name, ticket, minutes += 1
        end
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
