Gem::Specification.new do |s|
  s.name        = 'sfwash'
  s.version     = '0.1.0'
  s.summary     = 'SFWash'
  s.description = "CLI for scheduling SFWash (http://sfwash.com) pickups."
  s.authors     = ["Amber Feng"]
  s.email       = 'amber.feng@gmail.com'

  s.add_development_dependency('minitest')
  s.add_development_dependency('mocha')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/test_*.rb`.split("\n")
  s.executables   = ['sfwash']
  s.require_paths = %w[lib]
end
