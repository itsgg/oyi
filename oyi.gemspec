# frozen_string_literal: true

require_relative 'lib/oyi/version'

Gem::Specification.new do |spec|
  spec.name = 'oyi'
  spec.version = Oyi::VERSION
  spec.authors = ['Ganesh Gunasegaran']
  spec.email = ['me@itsgg.com']

  spec.summary = 'Ruby library for https://oyindonesia.com/ APIs'
  spec.homepage = 'https://www.bukukas.co.id/'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/itsgg/oyi'

  spec.add_dependency 'rest-client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
