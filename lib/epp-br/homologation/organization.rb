require 'mocks/organization'

module EPP
  module BR
    module Homologation
      class Organization < Base
        def check
          out @@client.organization.check @@config['document']
        end

        def create
          mock   = OrganizationMock.params @@config['document'], @@contact['id']
          create = @@client.organization.create 'NONEXISTE', mock.clone
          out create

          @@organization['id'] = create.id
          @@organization['pw'] = mock[:auth_info][:pw]

        end

        def info
          out @client.organization.info @@organization['id'], @@config['document']
        end

        def update

        end

        def info_again

        end
      end
    end
  end
end
