rubygems_version = Gem::Version.new(Gem::VERSION)
required = "2.1.9"
if rubygems_version < Gem::Version.new(required)
  raise "Please, upgrade rubygems to #{required}"
end
