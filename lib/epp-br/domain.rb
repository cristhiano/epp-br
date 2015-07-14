module EPP
  module BR
    class Domain < EPP::BR::Client

      # batch

      def check ids
        @command = EPP::Domain::Check.new(ids)
        EPP::Domain::CheckResponse.new(super())
      end

      # actions

      def info id
        @command = EPP::Domain::Info.new(id)
        EPP::Domain::InfoResponse.new(super())
      end

      def transfer id
        @command = EPP::Domain::Transfer.new(id)
        EPP::Domain::TransferResponse.new(super())
      end

      def delete id
        @command = EPP::Domain::Delete.new(id)
        EPP::Domain::DeleteResponse.new(super())
      end

      # creator / mutator

      def create id, info = {}
        @extension = XML::Node.new('create')

        @extension.namespaces.namespace = ns =
          XML::Namespace.new(@extension, 'brdomain', "urn:ietf:params:xml:ns:brdomain-1.0")

        organization = XML::Node.new('organization', info[:brorg])
        organization.namespaces.namespace = ns

        @extension << organization

        @extension = EPP::Requests::Extension.new(@extension)

        @command = EPP::Domain::Create.new(id, info)
        EPP::Domain::CreateResponse.new(super())
      end

      def update id, info = {}
        @command = EPP::Domain::Update.new(id, info)
        EPP::Domain::UpdateResponse.new(super())
      end
    end
  end
end
