require File.expand_path('../lib/epp-br/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Cristhiano Figueira"]
  gem.email         = ["crs@uw3.co"]
  gem.description   = %q{Client for communicating with the Nominet EPP}
  gem.summary       = %q{Nominet EPP (Extensible Provisioning Protocol) Client}
  gem.homepage      = "https://github.com/mig-snr/epp-br"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.name          = "epp-br"
  gem.require_paths = ["lib"]
  gem.version       = EPP::BR::VERSION

  # gem.extra_rdoc_files = %w(LICENSE README.md HISTORY.md)

  gem.add_dependency 'epp-client', '~> 2.1', '>= 2.1.0'
  gem.license       = 'MIT'
end
