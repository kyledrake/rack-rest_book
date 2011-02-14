module Rack
  class RestBook
    class RestBookError < StandardError; end
    
    HTTP_METHODS = %w(GET HEAD PUT POST DELETE OPTIONS)
    METHOD_OVERRIDE_PARAM_KEY = '_method'.freeze
    HTTP_METHOD_OVERRIDE_HEADER = 'HTTP_X_HTTP_METHOD_OVERRIDE'.freeze

    def initialize(app); @app = app end

    def call(env)
      if env['REQUEST_METHOD'] == 'POST'
        req = Request.new env
        meth = (req.params[METHOD_OVERRIDE_PARAM_KEY] || 'GET').to_s.upcase
        raise RestBookError, "invalid HTTP verb for method override: #{req.params[METHOD_OVERRIDE_PARAM_KEY]}" unless HTTP_METHODS.include?(meth)
        env['rack.methodoverride.original_method'] = env['REQUEST_METHOD'] and env['REQUEST_METHOD'] = meth unless meth == env['REQUEST_METHOD']
      end
      @app.call env
    end
  end
end