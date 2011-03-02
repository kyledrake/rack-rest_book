Rack::RestBook
==============================================

Makes all POST calls become GET. This allows us to do REST development with Facebook, which will alway sends a POST with iframes (as of March 10, 2011).
If you need to actually POST something, add this parameter to the query string: \_method=METHOD (so \_method=post, \_method=put, or \_method=delete).

Your application will still respond to real HTTP verbs as long as they are not POST. Rack::RestBook ignores other verbs.

The real documentation for this gem is in test/test.rb.

Installation and Usage
-------------

    # gem install rack-rest_book
    
    require 'rack/rest_book'
    use Rack::RestBook