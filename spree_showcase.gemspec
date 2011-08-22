Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_showcase'
  s.version     = '0.60.1'
  s.summary     = 'Spree Showcase'
  s.description = 'Awkward Showcase js for Spree'
  s.required_ruby_version = '>= 1.8.7'
  s.author            = 'Dom Stockdale'
  s.email             = 'dom.stockdale@gmail.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.60.1')
end
