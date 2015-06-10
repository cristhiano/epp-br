require 'epp-client'

module EPP
  module BR
    autoload :Auth,         'epp-br/auth'
    autoload :Client,       'epp-br/client'

    autoload :Contact,      'epp-br/contact'
    autoload :Organization, 'epp-br/organization'
  end
end
