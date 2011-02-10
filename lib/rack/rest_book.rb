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
        meth = req.params[METHOD_OVERRIDE_PARAM_KEY] || 'GET'
        meth = meth.to_s.upcase
        
        unless HTTP_METHODS.include?(meth) && !meth.nil? && !meth.empty?
          raise RestBookError, "invalid HTTP verb used in method override: #{req.params[METHOD_OVERRIDE_PARAM_KEY]}"
        end
        
        if HTTP_METHODS.include?(meth) && meth != env['REQUEST_METHOD']
          env['rack.methodoverride.original_method'] = env['REQUEST_METHOD']
          env['REQUEST_METHOD'] = meth
        end
      end

      @app.call env
    end
  end
end