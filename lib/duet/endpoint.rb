require 'addressable/template'

module Duet
  class Endpoint
    def initialize
      @versions = ['v1']
      @method = nil
      @pattern = nil
      @block = nil
    end

    def version(new_version)
      @versions << new_version
      @versions.uniq!
    end

    def name(new_name)
      @name = new_name
    end

    def method(new_method)
      @method = new_method
    end

    def match(pattern)
      @pattern = pattern
    end

    def respond(&new_block)
      @block = new_block
    end

    def template
      Addressable::Template.new(
        '{/prefix}/{version}' + (@pattern =~ /^\// ? @pattern : "/#{@pattern}")
      )
    end

    def call(env)
      @block.call(env)
    end

    def mount(route_set)
      @method = 'GET' unless @method
      route_set.add_route(self, route_conditions, route_defaults, @name.to_sym)
    end

  private
    def route_conditions
      {
        request_method: @method,
        # Having to call #to_regexp on this is FAR from ideal.
        # I'd really like to reverse-engineer why a Regexp works, but the
        # template it was derived from does not.
        fullpath: self.template.to_regexp
      }
    end

    ##
    # The `:prefix` variable should almost always be 'api', but for APIs served
    # from an 'api.example.com' style subdomain, the prefix can be set to `nil`.
    def route_defaults
      { prefix: 'api', version: 'v1' }
    end
  end
end
