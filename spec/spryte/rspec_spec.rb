require "spryte/rspec"

class RSpecContextMock
  include Spryte::RSpec::Macros
  def let(*args); end
  def before(*args); end
  def subject(*args); end
end

RSpec.describe Spryte::RSpec do

  describe Spryte::RSpec::Macros do

    subject(:rspec) { RSpecContextMock.new }

    shared_examples "setting http method verbs for rspec request specs" do |method_name|
      it "sets the right let variables" do
        disable_output do
          expect(rspec).to receive(:let).with(:method).once
          expect(rspec).to receive(:let).with(:through).once
          rspec.public_send(method_name, Spryte::RSpec::Macros::VALID_HTTP_VERBS.sample)
        end
      end
      it "raise exception when using an incorrect http verb" do
        disable_output do
          expect { rspec.public_send(method_name, :poo) }.to raise_exception(Spryte::RSpec::Macros::InvalidHTTPVerb)
        end
      end
    end

    describe "#method" do
      it_behaves_like "setting http method verbs for rspec request specs", :method
      it "shows a deprecation warning pointing to using #through" do
        expect { rspec.method(:get) }.to output(/#through/).to_stderr
      end
      context "when the major version of spryte is greater than 0" do
        it "does not respond to #method since it was deprecated" do
          if Integer(Spryte::MAJOR) > 0
            expect(Spryte::RSpec::Macros.instance_methods).to_not include :method
          end
        end
      end
    end

    describe "#through" do
      it_behaves_like "setting http method verbs for rspec request specs", :through
    end

    describe "#request" do
      it "sets the right let variables" do
        disable_output do
          aggregate_failures do
            expect(rspec).to receive(:let).with(:path).once
            expect(rspec).to receive(:let).with(:params).once
            expect(rspec).to receive(:let).with(:headers).once
            expect(rspec).to receive(:let).with(:method).once
            expect(rspec).to receive(:let).with(:through).once
            rspec.request(:my_awesome_request)
          end
        end
      end
    end

  end

end
