require 'mocks/contact'

module EPP
  module BR
    module Homologation
      class Contact < Base
        def create
          id     = ContactMock.id
          params = ContactMock.params

          create = @@client.contact.create id, params.clone

          @@contact[:id] = create.id
          @@contact[:pw] = params[:auth_info][:pw]

          out create
        end

        def info
          out @@client.contact.info @@contact[:id]
        end

        def update
          params = ContactMock.change

          out @@client.contact.update @@contact[:id], params.clone
        end
      end
    end
  end
end
