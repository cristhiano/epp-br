module EPP
  module RegistroBR
    class Client < EPP::Client
      def initialize
        auth = EPP::RegistroBR::Auth.new

        super(
          auth.username,
          auth.password,
          auth.host,
          auth.options
        )
      end

      def contact
        EPP::RegistroBR::Contact.new
      end

      def organization
        EPP::RegistroBR::Organization.new
      end

      def check
        @resp = super(@command)
      end

      def create
        @resp = super(@command)
      end

      def update
        @resp = super(@command)
      end

      def info
        @resp = super(@command)
      end

      def transfer
        @resp = super(@command)
      end

      def delete
        @resp = super(@command)
      end

      def renew
        @resp = super(@command)
      end
    end
  end
end
