module EPP
  module Domain
    class CreateResponse
      # Return the ticket number of the domain creation if the request was successful.
      #
      # @return [String] Ticket number
      def ticket
        return nil unless success? || pending?
        @ticket ||= @response.extension.find('//brdomain:ticketNumber').first.content
      end
    end

    class Info
      def initialize(name, ticket = nil)
        @name = name
        @ticket = ticket if ticket
      end
    end
  end
end
