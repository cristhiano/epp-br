module EPP
  module RegistroBR
    class Auth
      def initialize
        ssl_context = OpenSSL::SSL::SSLContext.new(:TLSv1)
        ssl_context.cert = OpenSSL::X509::Certificate.new(File.open('config/epp-registro-br/client.pem'))
        ssl_context.key = OpenSSL::PKey::RSA.new(File.open('config/epp-registro-br/client.pem'))
        ssl_context.ca_file = 'config/epp-registro-br/root.pem'
        ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
        options = {ssl_context: ssl_context}

        @credentials = {
          username: '405',
          password: '123456',
          host:     'beta.registro.br',
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
