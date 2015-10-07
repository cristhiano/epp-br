module EPP
  module BR
    class Org
      attr_accessor :command,
                    :extension,
                    :response

      def initialize client
        @client = client
      end

      def check *ids
        @extension = XML::Node.new('check')

        @extension.namespaces.namespace = ns =
          XML::Namespace.new(@extension, 'brorg', "urn:ietf:params:xml:ns:brorg-1.0")

        ids = ids.flatten

        ids.each do |_id|
          id = XML::Node.new('id', _id.clone.gsub!(/[[:punct:]]/, ''))
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

        @command = EPP::Contact::Check.new(ids.map{|id| id.gsub!(/[[:punct:]]/, '')})
        @request = @client.check(@command, @extension)
        @response = EPP::Contact::CheckResponse.new(@request)

        @response
      end
    end
  end
end
