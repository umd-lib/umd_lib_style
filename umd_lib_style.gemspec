$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "umd_lib_style/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "umd_lib_style"
  s.version     = UMDLibStyle::VERSION
  s.authors     = ["Peter Eichman"]
  s.email       = ["peichman@umd.edu"]
  s.homepage    = "https://github.com/umd-lib"
  s.summary     = "UMD Libraries branding for Rails applications."
  s.description = "Provides UMD Libraries branding for Rails applications. Uses Bootstrap 3.3.6."

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
