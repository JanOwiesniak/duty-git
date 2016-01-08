# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duty/git/version'

Gem::Specification.new do |spec|
  spec.name          = "duty-git"
  spec.version       = Duty::Git::VERSION
  spec.authors       = ["Jan Owiesniak"]
  spec.email         = ["owiesniak@mailbox.org"]

  spec.summary       = %q{git specific tasks for the duty task manager}
  spec.description   = %q{git specific tasks for the duty task manager}
  spec.homepage      = "https://github.com/JanOwiesniak/duty-git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "duty", "~> 0.4"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
