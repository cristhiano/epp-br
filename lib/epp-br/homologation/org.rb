module EPP
  module BR
    module Homologation
      class Org < Base
        def check
          fixture = OrganizationFixture.info

          out @client.organization.check fixture.clone[:brorg][:organization]
        end

        def create
          fixture = OrganizationFixture.info({
            brorg: {
              organization: '13.263.349/0001-68',
              contact:      @contact_id,
              responsible:  "Drunk driver"
            }
          })

          create = @client.organization.create 'NONEXISTE', fixture.clone
          p create.to_xml
          @brorg_id   = create.id
          @brorg_pw   = fixture[:auth_info][:pw]
          @brorg_cnpj = fixture[:brorg][:organization]

          out create
        end

        def info
          out @client.organization.info @brorg_id, @brorg_cnpj
        end

        def update

        end

        def info_again

        end
      end
    end
  end
end
