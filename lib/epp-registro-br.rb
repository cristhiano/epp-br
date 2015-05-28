require 'epp-client'

module EPP
  module RegistroBR
    autoload :Auth,       'epp-registro-br/auth'
    autoload :Client,     'epp-registro-br/client'

    autoload :Contact,    'epp-registro-br/contact'
  end
end
