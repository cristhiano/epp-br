require File.expand_path('../lib/epp-registro-br/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Cristhiano Figueira"]
  gem.email         = ["crs@uw3.co"]
  gem.description   = %q{Client for communicating with the Nominet EPP}
  gem.summary       = %q{Nominet EPP (Extensible Provisioning Protocol) Client}
  gem.homepage      = "https://github.com/cristhiano81/epp-registro-br"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "epp-registro-br"
  gem.require_paths = ["lib"]
  gem.version       = EPP::RegistroBR::VERSION

  # gem.extra_rdoc_files = %w(LICENSE README.md HISTORY.md)

  gem.add_dependency 'epp-client', '~> 2.1', '>= 2.1.0'
  gem.license       = 'MIT'
end
