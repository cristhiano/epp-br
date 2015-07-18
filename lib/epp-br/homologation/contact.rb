module EPP
  module BR
    module Homologation
      class Contact < Base
        def create
          fixture = ContactFixture.info
          create = @client.contact.create 'NONEXISTE', fixture.clone
          @contact_id = create.id
          @contact_pw = fixture[:auth_info][:pw]

          out create
        end

        def info
          out @client.contact.info @contact_id
        end

        def update
          fixture = ContactFixture.change

          out @client.contact.update @contact_id, fixture
        end
      end
    end
  end
end
