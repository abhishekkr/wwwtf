# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wwwtf/version'

Gem::Specification.new do |gem|
  gem.name          = "wwwtf"
  gem.version       = Wwwtf::VERSION
  gem.authors       = ["abhishekkr"]
  gem.email         = ["abhikumar163@gmail.com"]
  gem.description   = %q{World Wide Web's Trolls and Flaws giving varied Trolls & Flaws analyzing the BAD WWW around.}
  gem.summary       = %q{World Wide Web's Trolls and Flaws}
  gem.homepage      = "https://github.com/abhishekkr/wwwtf"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.executables   = %w( wwwtf )

  gem.add_runtime_dependency 'xml-motor', '>= 0.1.6'
  gem.add_runtime_dependency 'arg0', '>= 0.0.2'
end
