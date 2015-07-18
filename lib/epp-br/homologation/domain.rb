module EPP
  module BR
    module Homologation
      class Domain < Base
        def check
          @domain_name = 'uw3.com.br' #DomainFixture.name
          out @client.domain.check @domain_name
        end

        def create
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

        def info
          info = @client.domain.info @domain_name, @domain_ticket

          out info
        end

        def update
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

        def create_again

        end

        def info_again

        end

        def renew

        end

        def renewed_update

        end

        def delete

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
      end
    end
  end
end
