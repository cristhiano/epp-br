require 'epp-client'
require 'epp-client/domain'

module EPP
  module BR
    autoload :Auth,         'epp-br/auth'
    autoload :Client,       'epp-br/client'
    autoload :Server,       'epp-br/server'

    autoload :Domain,       'epp-br/domain'
    autoload :Contact,      'epp-br/contact'
    autoload :Organization, 'epp-br/organization'

    autoload :Org,          'epp-br/brorg'

    class Org
      autoload :CheckResponse, 'epp-br/brorg/check_response'
    end

    module Homologation
      autoload :Base,         'epp-br/homologation/base'
      autoload :Contact,      'epp-br/homologation/contact'
      autoload :Domain,       'epp-br/homologation/domain'
      autoload :Organization, 'epp-br/homologation/organization'
      autoload :Poll,         'epp-br/homologation/poll'
      autoload :Prepare,      'epp-br/homologation/prepare'
    end
  end
end
