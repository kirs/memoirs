RubyGem.destroy_all

rails = RubyGem.create(name: "rails")
devise = RubyGem.create(name: "devise")

%w(2.3.15 3.1.0 3.2.0 4.0.0).each do |v|
  Version.create(ruby_gem: rails, number: v, release_notes: "releasing #{v}")
end

%w(2.9.0 3.0.0).each do |v|
  Version.create(ruby_gem: devise, number: v, release_notes: "releasing #{v}")
end

