module Spryte
  module RSpec
    module Macros

      def host(domain)
        before(:each) { self.host = domain }
      end

      def request(name)

        host ENV.fetch("SPRYTE_RSPEC_HOST", "localhost")

        let(:method) { :get }
        let(:path) { "/" }
        let(:params) { Hash[] }
        let(:headers) { {
          "HTTP_ACCEPT"  => "application/json",
          "CONTENT_TYPE" => "application/json"
        } }

        subject(name) {
          parameters = [ :get ].include?(method) ? params : params.to_json
          send method, path.to_s, parameters, headers
        }
      end

      def method(verb)
        let(:method) { verb.to_sym }
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

    end
  end
end