module EPP
  module RegistroBR
    module Ratification
      class Basic
        def connect
          auth = EPP::RegistroBR::Auth.new
          @server = EPP::Server.new(
            auth[:username],
            auth[:password],
            auth[:host],
            auth[:options]
          )
          @server.connection
        end
      end
    end
  end
end
