lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = 'capistrano-extras'
  spec.version     = '0.1.0'
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Arne Brasseur']
  spec.email       = ['arne.brasseur@gmail.com']
  spec.homepage    = 'https://github.com/arnebrasseur/capistrano-extras'
  spec.summary     =
  spec.description = 'Assorted Capistrano tasks'

  spec.add_dependency 'capistrano', '>=2.0.0'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'

  spec.require_path = 'lib'
  spec.files        = Dir.glob('**/*.rb')
end
