module EPP
  module BR
    module Homologation

      ##
      # Prepares the beta.registro.br host to the homologation process by
      # deleting the configured organization and domains. This is necessary
      # since aspects related with this informations need to be real.
      # see EPP::BR::Homologation::Base
      #
      class Prepare < Base
        def initialize
          # contact
          organization
          domains
        end

        # def contact
        #   unless is_contact_available?
        #     out @@client.contact.delete @@config['contact']
        #   end
        # end

        def organization
          raise is_organization_available?
          unless is_organization_available?
            out @@client.organization.delete 'NONEXISTE', @@config['document']
          end
        end

        def domains
          @@config['domains'].each do |domain|
            unless is_domain_available? domain['name']
              out @@client.domain.delete domain['name']
            end
          end
        end

        # def is_contact_available?
        #   @@client.contact.check(@@config['contact']).available?
        # end

        def is_organization_available?
          check = @@client.organization.check(@@config['document'])
          puts check.to_xml
          check.available?
        end

        def is_domain_available? name
          @@client.domain.check(name).available?
        end
      end
    end
  end
end
