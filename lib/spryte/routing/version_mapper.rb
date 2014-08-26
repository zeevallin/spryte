module Spryte
  module Routing
    module VersionMapper

      extend ActiveSupport::Concern

      def version(number, &block)
        namespace [ "v", number ].join, defaults: { format: "json" }, format: false, &block
      end

    end
  end
end

ActionDispatch::Routing::Mapper.include Spryte::Routing::VersionMapper