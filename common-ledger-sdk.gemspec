# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = "common-ledger-sdk"
  gem.version     = "0.0.1"
  gem.description = "Official CommonLedger API library client for ruby"
  gem.summary     = "Official CommonLedger API library client for ruby"

  gem.author   = "Patrick Hindmarsh"
  gem.email    = "patrick@hindmar.sh"
  gem.homepage = "https://commonledger.com"
  gem.license  = "MIT"

  gem.require_paths = ['lib']

  gem.files = Dir["lib/**/*"]

  gem.add_dependency "faraday", "~> 0.8.8"
  gem.add_dependency "json", "~> 1.7.7"
end
