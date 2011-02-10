Bundler.setup
require 'bundler'
require 'test/unit'
require 'rack/test'
require 'contest'
require 'sinatra/base'
require 'lib/rack/rest_book'

def mock_app(base=Sinatra::Base, &block); @app = Sinatra.new base, &block end
def app; @app end

class RackRestBookTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  context 'an sinatra app using Rack::RestBook as middleware' do    
    setup do
      mock_app do
        set :show_exceptions, false
        use Rack::RestBook
        get('/')    {'get'}
        post('/')   {'post'}
        put('/')    {'put'}
        delete('/') {'delete'}
      end
    end
    
    test 'should translate POST requests to GET if method override is missing' do
      post '/'
      assert_equal 'get', last_response.body
    end
    
    test 'should provide GET, PUT and DELETE when set in method override' do
      %w{post put delete}.each do |meth|
        send meth.to_sym, '/', '_method' => meth.upcase
        assert_equal meth, last_response.body
      end
    end
    
    test 'responds to real HTTP verbs except POST' do
      %w{get put delete}.each do |meth|
        send meth.to_sym, '/'
        assert_equal meth, last_response.body
      end
    end
    
    test 'ignores method override with real HTTP verbs except POST' do
      %w{get put delete}.each do |meth|
        send meth.to_sym, '/', '_method' => 'POST'
        assert_equal meth, last_response.body
      end
    end
    
    test 'should respond to method override in a case insensitive way' do
      ['pOsT', 'pUt', 'DeLEtE', 'GeT'].each do |meth|
        post '/', '_method' => meth
        assert_equal meth.downcase, last_response.body
      end
    end
    
    test 'should fail if given crazy method override' do
      assert_raises Rack::RestBook::RestBookError do
        post '/', '_method' => 'dade_murphy'
      end
    end
  end
end