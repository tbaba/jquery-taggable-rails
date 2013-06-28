# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jquery-taggable-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "jquery-taggable-rails"
  spec.version       = Jquery::Taggable::Rails::VERSION
  spec.authors       = ["Tatsuro Baba"]
  spec.email         = ["harakirisoul@gmail.com"]
  spec.description   = %q{jquery-taggable-rails is simple javascript to make tags.}
  spec.summary       = %q{jquery-taggable-rails is simple javascript to make tags.}
  spec.homepage      = "https://github.com/tbaba/jquery-taggable-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

	spec.add_runtime_dependency 'railties', '>= 3.1.1'
end
