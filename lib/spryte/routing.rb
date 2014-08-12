module Spryte
  module Routing
    DEFAULTS = { format: "json" }.freeze
    require "spryte/routing/version_mapper"
    require "spryte/routing/fallback_mapper"
  end
end