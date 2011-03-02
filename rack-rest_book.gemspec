Gem::Specification.new do |s|
  s.name = "rack-rest_book"
  s.version = "1.0.2"
  s.authors = ['Kyle Drake']
  s.email = ["kyle.drake@dachisgroup.com"]
  s.homepage = "http://github.com/dachisgroup/rack-rest_book"
  s.summary = "Makes all POST calls assume GET for Facebook Development"
  s.description = "Makes all POST calls assume GET. This allows us to do REST development with Facebook, which always sends POST"
  s.files = Dir["{lib/rack,test}/**/*"] + Dir["[A-Z]*"]
  s.require_path = "lib"
  s.rubyforge_project = s.name
  s.add_dependency 'rack', '>= 1.0.0'
  s.add_development_dependency 'sinatra', '=1.1.2'
  s.add_development_dependency 'contest', '=0.1.2'
end
