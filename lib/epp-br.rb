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

    autoload :Homologation, 'epp-br/homologation/base'
  end
end
