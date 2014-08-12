module Spryte
  module RSpec
    module Helpers

      def json
        expect(response.body).to_not be_empty, lambda { "Expected there to be a JSON root, but the response body is empty." }
        @json ||= JSON.parse(response.body).with_indifferent_access
      rescue JSON::ParserError
        raise "Invalid JSON response:\n\n#{response.body}"
      end

      def errors
        json.fetch(:errors) { [] }
      end

    end
  end
end