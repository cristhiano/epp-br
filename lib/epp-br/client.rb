module EPP
  module BR
    class Client < EPP::Client
      def initialize
        auth = EPP::BR::Auth.new

        super(
          auth.username,
          auth.password,
          auth.host,
          auth.options
        )

        puts @command.to_xml if @command
      end

      # Entities

      def contact
        EPP::BR::Contact.new
      end

      def organization
        EPP::BR::Organization.new
      end

      def domain
        EPP::BR::Domain.new
      end

      # Commands

      # creator

      def create
        super(@command, @extension)
      end

      # info

      def info
        super(@command, @extension)
      end

      # batch info

      def check
        puts @command.to_xml
        puts @extension.to_xml
        super(@command, @extension)
      end

      # message poll

      def poll
        super()
      end

      def ack(msgID)
        super(msgID)
      end

      # mutators

      def update
        puts @command.to_xml
        # puts @extension.to_xml
        super(@command, @extension)
      end

      def transfer
        super(@command, @extension)
      end

      def renew
        super(@command, @extension)
      end

      # destructor

      def delete
        super(@command, @extension)
      end
    end
  end
end
