module EPP
  module BR
    class Organization < EPP::BR::Client
      def check cnpj
        check = XML::Node.new('check')

        check.namespaces.namespace = ns =
          XML::Namespace.new(check, 'brorg', "urn:ietf:params:xml:ns:brorg-1.0")

        id = XML::Node.new('id', 'e123456')
        id.namespaces.namespace = ns

        organization = XML::Node.new('organization', "005.506.560/0001-36")
        organization.namespaces.namespace = ns

        cd = XML::Node.new('cd')
        cd.namespaces.namespace = ns

        cd << id
        cd << organization

        check << cd

        check = EPP::Requests::Extension.new(check)

        puts check.to_xml

        # @command = EPP::Contact::Check.new(ids)
        # EPP::Contact::CheckResponse.new(super())
      end

      def create id, info = {}
        # @extension  = XML::Node.new('brorg')
        # @extension.namespaces.namespace = ns =
        #   XML::Namespace.new(@extension, 'create', "urn:ietf:params:xml:ns:brorg-1.0")
        #
        # xattr = XML::Attr.new(@extension, "organization", info[:organization])
        # xattr.namespaces.namespace = XML::Namespace.new(@domain_info, 'xsi', 'http://www.w3.org/2001/XMLSchema-instance')
        #
        # @domain_info << XML::Node.new('name', 'example.com', ns)
        #
        # @extension = EPP::Requests::Extension.new(@domain_info)


        @command = EPP::Contact::Create.new(id, info, @extension)
        EPP::Contact::CreateResponse.new(super())
      end

      def update id, info = {}
        @command = EPP::Contact::Update.new(id, info)
        EPP::Contact::UpdateResponse.new(super())
      end

      def info id
        @command = EPP::Contact::Info.new(id)
        EPP::Contact::InfoResponse.new(super())
      end

      def transfer id
        @command = EPP::Contact::Transfer.new(id)
        EPP::Contact::TransferResponse.new(super())
      end

      def delete id
        @command = EPP::Contact::Delete.new(id)
        EPP::Contact::DeleteResponse.new(super())
      end
    end
  end
end
