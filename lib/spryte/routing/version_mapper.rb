module Spryte
  module Routing
    module VersionMapper

      extend ActiveSupport::Concern

      def version(number, &block)
        namespace (v_string = [ "v", number ].join), defaults: { format: "json" }, &block
        match "/*path", to: [ v_string, "base#not_found" ].join("/"), via: :all, defaults: { format: "json" }
      end

    end
  end
end

ActionDispatch::Routing::Mapper.include Spryte::Routing::VersionMapper