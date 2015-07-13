module EPP
  module BR
    class Server < EPP::Server
      def initialize
        auth = EPP::BR::Auth.new

        super(
          auth.username,
          auth.password,
          auth.host,
          auth.options
        )
      end
    end
  end
end
