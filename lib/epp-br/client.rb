module EPP
  module BR
    class Client < EPP::Client
      def initialize env = 'production'
        if env == 'production'
          auth = EPP::BR::Auth.new

          super(
            auth.username,
            auth.password,
            auth.host,
            auth.options
          )
        else
          super('user', 'password', 'test.host.epp')
        end
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
        super(@command, @extension = nil)
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
