module Spryte
  module RSpec
    module Macros

      class InvalidHTTPVerb < StandardError; end

      def host(domain)
        before(:each) { self.host = domain }
      end

      def request(name)

        host ENV.fetch("SPRYTE_RSPEC_HOST", "localhost")

        through(:get)

        let(:path) { "/" }
        let(:params) { Hash[] }
        let(:headers) { {
          "HTTP_ACCEPT"  => "application/json",
          "CONTENT_TYPE" => "application/json"
        } }

        subject(name) {
          parameters = [ :get ].include?(through) ? params : params.to_json
          send through, path.to_s, parameters, headers
        }
      end

      def through(verb)
        raise InvalidHTTPVerb, invalid_http_verb_message(verb) unless valid_http_verb?(verb)
        let(:through) { verb.to_sym }
        let(:method) { through }
      end

      def method(verb)
        warn "#{ Kernel.caller.first }: `#method' is deprecated due to a collision with Object#method in ruby core, please use `#through' instead."
        through(verb)
      end

      def path(name)
        let(:path) { Pathname(name) }
      end

      def accept(mime_type)
        if mime_type = Mime::Type.lookup_by_extension(mime_type)
          before(:each) { headers.merge!("HTTP_ACCEPT" => mime_type.to_s) }
        end
      end

      def content_type(mime_type)
        if mime_type = Mime::Type.lookup_by_extension(mime_type)
          before(:each) { headers.merge!("CONTENT_TYPE" => mime_type.to_s) }
        end
      end

      private def valid_http_verb?(verb)
        VALID_HTTP_VERBS.include?(verb)
      end

      private def invalid_http_verb_message(verb)
        "#{verb} is not a valid http verb.\nValid verbs are:\n#{VALID_HTTP_VERBS.map(&:inspect).join("\n")}"
      end

      VALID_HTTP_VERBS = [
        :get,
        :head,
        :post,
        :patch,
        :put,
        :proppatch,
        :lock,
        :unlock,
        :options,
        :propfind,
        :delete,
        :move,
        :copy,
        :mkcol,
        :trace,
      ]
    end
  end
end
