module Spryte
  module Routing
    module VersionMapper

      extend ActiveSupport::Concern

      def version(number, &block)
        namespace (v_string = [ "v", number ].join), defaults: Spryte::Routing::DEFAULTS, &block
        match "/*path", to: [ v_string, "base#not_found" ].join("/"), via: :all, defaults: Spryte::Routing::DEFAULTS
      end

    end
  end
end

ActionDispatch::Routing::Mapper.include Spryte::Routing::VersionMapper