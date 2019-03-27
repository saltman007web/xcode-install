# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcode/install/version'

FILES = case git_files = %x(git ls-files -z)
when ''
  # Not a git repo, assume archive and include the whole tree
  Dir['**/*']
else
  git_files.split("\x0")
end

Gem::Specification.new do |spec|
  spec.name          = 'xcode-install'
  spec.version       = XcodeInstall::VERSION
  spec.authors       = ['Boris Bügling']
  spec.email         = ['boris@icculus.org']
  spec.summary       = 'Xcode installation manager.'
  spec.description   = 'Download, install and upgrade Xcodes with ease.'
  spec.homepage      = 'https://github.com/neonichu/xcode-install'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.0.0'

  spec.files = FILES.reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # CLI parsing
  spec.add_dependency 'claide', '>= 0.9.1', '< 1.1.0'

  # contains spaceship, which is used for auth and dev portal interactions
  spec.add_dependency 'fastlane', '>= 2.1.0', '< 3.0.0'

  spec.add_development_dependency 'bundler', '~> 2.0.1'
  spec.add_development_dependency 'rake', '~> 10.0'
end
