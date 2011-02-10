Rack::RestBook
==============================================

Makes all POST calls become GET. This allows us to do REST development with Facebook, which always sends POSTs.
If you need to actually POST anything, add this parameter to the query string: _method=METHOD (so _method=POST, _method=PUT, or _method=DELETE).

Installation and Usage
-------------

    gem install rack-rest_book
    
    require 'rack/rest_book'
    use Rack::RestBook