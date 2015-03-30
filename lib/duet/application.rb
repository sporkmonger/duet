require 'rack/mount'
require 'duet/endpoint'

module Duet
  class Application
    def initialize
      @routes = Rack::Mount::RouteSet.new
    end

    def mount(endpoint)
      endpoint.mount(@routes)
      @routes.rehash
    end

    def endpoint(&block)
      endpoint = Endpoint.new
      endpoint.instance_exec(&block)
      mount(endpoint)
    end

    attr_reader :routes

    def call(env)
      @routes.call(env)
    end
  end
end
