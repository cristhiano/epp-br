module EPP
  module BR
    class Auth
      def initialize
        require 'yaml'

        credentials_file = YAML.load_file('config/epp-br/credentials.yml')
        credentials = credentials_file['epp-br']['test']

        ssl_cert  = OpenSSL::X509::Certificate.new(File.open(credentials['ssl']['cert']))
        ssl_key   = OpenSSL::PKey::RSA.new(File.open(credentials['ssl']['key']))
        ssl_ca    = credentials['ssl']['ca']

        ssl_context =             OpenSSL::SSL::SSLContext.new(:TLSv1)
        ssl_context.cert =        ssl_cert
        ssl_context.key =         ssl_key
        ssl_context.ca_file =     ssl_ca
        ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER

        options = {ssl_context: ssl_context}

        @credentials = {
          host:     credentials['host'],
          username: credentials['username'].to_s,
          password: credentials['password'].to_s,
          options:  options
        }

      end

      def username
        @credentials[:username]
      end

      def password
        @credentials[:password]
      end

      def host
        @credentials[:host]
      end

      def options
        @credentials[:options]
      end
    end
  end
end
