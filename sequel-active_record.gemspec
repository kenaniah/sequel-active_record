# coding: utf-8
#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "sequel-active_record"
  spec.version       = "0.0.0"
  spec.authors       = ["Kenaniah Cerny"]
  spec.email         = ["kenaniah@gmail.com"]

  spec.summary       = "Provides ActiveRecord compatibility for Sequel"
  spec.homepage      = "https://github.com/kenaniah/sequel-active_record"

  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ["lib"]

  spec.add_dependency "sequel"

  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
end
