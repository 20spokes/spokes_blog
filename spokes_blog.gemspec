# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spokes_blog/version'

Gem::Specification.new do |spec|
  spec.name          = "spokes_blog"
  spec.version       = SpokesBlog::VERSION
  spec.authors       = ["Matt Obarzanek", "Ryan Fischer"]
  spec.email         = ["matt.obarzanek@20spokes.com", "ryan.fischer@20spokes.com"]
  spec.description   = %q{Simple blog scaffolding that can be added to almost any existing Rails site.}
  spec.summary       = %q{Setups basic blog structure for rails}
  spec.homepage      = "https://github.com/20spokes/spokes_blog"
  spec.license       = "MIT"

  spec.files = Dir.glob("{lib}/**/*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails"
  spec.add_dependency "acts-as-taggable-on"
  spec.add_dependency "haml"
  spec.add_dependency "kaminari"

end
