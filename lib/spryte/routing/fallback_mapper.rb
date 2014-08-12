module Spryte
  module Routing
    module FallbackMapper

      extend ActiveSupport::Concern

      def fallback(to)
        match "/(errors/):status", to: "base#error", via: :all, constraints: { status: /\d{3}/ }, defaults: Spryte::Routing::DEFAULTS
        match "*path", to: to, via: :all
        root to: to
      end

    end
  end
end

ActionDispatch::Routing::Mapper.include Spryte::Routing::FallbackMapper