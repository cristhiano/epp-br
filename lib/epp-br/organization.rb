module EPP
  module BR
    class Organization < EPP::BR::Client
      def check *ids
        @extension = XML::Node.new('check')

        @extension.namespaces.namespace = ns =
          XML::Namespace.new(@extension, 'brorg', "urn:ietf:params:xml:ns:brorg-1.0")

        ids = ids.flatten

        ids.each do |_id|
          id = XML::Node.new('id', _id)
          id.namespaces.namespace = ns

          organization = XML::Node.new('organization', _id)
          organization.namespaces.namespace = ns

          cd = XML::Node.new('cd')
          cd.namespaces.namespace = ns

          cd << id
          cd << organization

          @extension << cd
        end

        @extension = EPP::Requests::Extension.new(@extension)

        @command = EPP::Contact::Check.new(ids)
        EPP::Contact::CheckResponse.new(super())
      end

      def create id, info = {}
        @extension = XML::Node.new('create')
        @extension.namespaces.namespace = ns =
          XML::Namespace.new(@extension, 'brorg', "urn:ietf:params:xml:ns:brorg-1.0")

        organization = XML::Node.new('organization', info[:brorg][:organization])
        organization.namespaces.namespace = ns
        @extension << organization

        contact = XML::Node.new('contact', info[:brorg][:contact])
        contact.namespaces.namespace = ns
        contact['type'] = "admin"
        @extension << contact

        responsible = XML::Node.new('responsible', info[:brorg][:responsible])
        responsible.namespaces.namespace = ns
        @extension << responsible

        @extension = EPP::Requests::Extension.new(@extension)

        @command = EPP::Contact::Create.new(id, info)
        EPP::Contact::CreateResponse.new(super())
      end

      def update id, info = {}
        @command = EPP::Contact::Update.new(id, info)
        EPP::Contact::UpdateResponse.new(super())
      end

      def info id, cnpj
        @extension = XML::Node.new('info')
        @extension.namespaces.namespace = ns =
          XML::Namespace.new(@extension, 'brorg', "urn:ietf:params:xml:ns:brorg-1.0")

        organization = XML::Node.new('organization', cnpj)
        organization.namespaces.namespace = ns
        @extension << organization

        @extension = EPP::Requests::Extension.new(@extension)

        @command = EPP::Contact::Info.new(id)
        EPP::Contact::InfoResponse.new(super())
      end

      def transfer id
        @command = EPP::Contact::Transfer.new(id)
        EPP::Contact::TransferResponse.new(super())
      end

      def delete id, cnpj
        @extension = XML::Node.new('delete')
        @extension.namespaces.namespace = ns =
          XML::Namespace.new(@extension, 'brorg', "urn:ietf:params:xml:ns:brorg-1.0")

        organization = XML::Node.new('organization', cnpj)
        organization.namespaces.namespace = ns
        
        @extension << organization

        @extension = EPP::Requests::Extension.new(@extension)

        @command = EPP::Contact::Delete.new(id)
        EPP::Contact::DeleteResponse.new(super())
      end
    end
  end
end
