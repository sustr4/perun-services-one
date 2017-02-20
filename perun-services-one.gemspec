# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'perun/services/one/version'

Gem::Specification.new do |spec|
  spec.name          = "perun-services-one"
  spec.version       = Perun::Services::One::VERSION
  spec.authors       = ["Zdenek Sustr\n"]
  spec.email         = ["sustr4@cesnet.cz"]

  spec.summary       = %q{Synchronization of user accounts from the Perun IM to OpenNebula}
  spec.description   = %q{This toll accepts a YAML description of the desired state of user accounts in OpenNebula, compares it to the present state, and makes changes to synchronize OpenNebula with the target state.}
  spec.homepage      = "https://github.com/CESNET/perun-services-one"
  spec.license = 'Apache License, Version 2.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "opennebula", ">= 5.2.1", "< 6"
  spec.add_runtime_dependency     "thor", ">= 0.19.4", "< 1"
  spec.add_runtime_dependency     "json", ">= 2.0.0", "< 3"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry', '>= 0.10'
end
