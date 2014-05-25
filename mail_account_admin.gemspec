$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mail_account_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mail_account_admin"
  s.version     = MailAccountAdmin::VERSION
  s.authors     = ["fattymiller"]
  s.email       = ["fatty@mobcash.com.au"]
  s.homepage    = "https://github.com/fattymiller/base_jump"
  s.summary     = "Keep track of your email accounts."
  s.description = "Administer your email accounts and manage how they can be used."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.1"
  
  s.add_dependency "base_jump_commands_base"
  s.add_dependency "base_jump_plugins_base"
  
  s.add_dependency "attr_encrypted"

  s.add_development_dependency "sqlite3"
end
