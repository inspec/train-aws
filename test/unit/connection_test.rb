# This is a unit test for the AWS Train plugin
# Its job is to verify that the Connection class is setup correctly.

# Include our test harness
require_relative '../helper'

# Load the class under test, the Connection definition.
require 'train-aws/connection'

# Because InSpec is a Spec-style test suite, we're going to use MiniTest::Spec
# here, for familiar look and feel. However, this isn't InSpec (or RSpec) code.
describe TrainPlugins::Aws::Connection do

  # When writing tests, you can use `let` to create variables that you
  # can reference easily.

  # This is a long name.  Shorten it for clarity.
  let(:connection_class) { TrainPlugins::Aws::Connection }
  let(:connection) { connection_class.new({}) }
  let(:cache) { connection.instance_variable_get(:@cache) }

  # Some tests through here use minitest Expectations, which attach to all
  # Objects, and begin with 'must' (positive) or 'wont' (negative)
  # See https://ruby-doc.org/stdlib-2.1.0/libdoc/minitest/rdoc/MiniTest/Expectations.html

  describe 'connection definition' do

    it "should inherit from the Train Connection base" do
      # For Class, '<' means 'is a descendant of'
      (connection_class < Train::Plugins::Transport::BaseConnection).must_equal(true)
    end

    # Since this is an API-type connection, we MUST NOT implement these three.
    [
      :file_via_connection,
      :run_command_via_connection,
      :local?,
    ].each do |method_name|
      it "should NOT provide a #{method_name}() method" do
        # false passed to instance_methods says 'don't use inheritance'
        connection_class.instance_methods(false).wont_include(method_name)
      end
    end

    # Ensure Train knows this is not local.
    it "should declare itself as a non-local transport" do
      connection_class.new(Hash.new).local?.must_equal(false)
    end
  end


  # As an API-type plugin, we get to decide how to talk to our API.

  describe 'API-SDK interface' do
    # We use the aws-sdk, which provides two metaphors for accessing AWS objects:
    # a client-based approach (which focuses on explicit API calls) and a
    # resource-based approach  (which allows you to ask for all EC2 instances,
    # and the SDK will handle pagination, etc.)
    [
      :aws_client,
      :aws_resource,
    ].each do |method_name|
      it "should provide a #{method_name}() method" do
        # false passed to instance_methods says 'don't use inheritance'
        connection_class.instance_methods(false).must_include(method_name)
      end
    end

    describe 'aws_client' do
      # The aws_client call simply instantiates a Class that you provide.
      # Normally, that would be something like Aws::Iam::Client.
      # For testing, we're just passing Object.
      it 'should instantiate things and cache them when caching is enabled' do
        connection.enable_cache(:api_call) # Just being explicit; this is the default
        client_one = connection.aws_client(Object)
        client_one.is_a?(Object).must_equal true
        cache[:api_call].count.must_equal 1
        client_two = connection.aws_client(Object)
        client_one.must_equal client_two
      end

      it 'should instantiate things without caching them when caching is disabled' do
        connection.disable_cache(:api_call)
        client_one = connection.aws_client(Object)
        client_one.is_a?(Object).must_equal true
        cache[:api_call].count.must_equal 0
        client_two = connection.aws_client(Object)
        client_one.wont_equal client_two
      end
    end

    describe 'aws_resource' do
      class DummyAwsResource
        attr_reader :args
        def initialize(args)
          @args = args
        end
      end

      # Current behavior is to never cache in resource mode, for fear of blowing memory.
      # We could be more sophisticated and limit the cache size. PRs welcome.
      describe 'when caching is enabled' do
        it 'should cache miss on a resource when the args match' do
          resource_args = { user: 1, name: 'test_user' }
          resource_one = connection.aws_resource(DummyAwsResource, resource_args)
          resource_one.args.must_equal resource_args

          resource_two = connection.aws_resource(DummyAwsResource, resource_args)
          resource_two.wont_equal(resource_one)
          cache[:api_call].count.must_equal 0
        end
      end
    end
  end


  # Train connections need to be able to generate a UUID for targets.
  # train-aws uses the account ID.
  describe 'uuid facility' do
    class AwsCallerId
      def account
        "123456789012"
      end
    end

    class StsClient
      def get_caller_identity
        AwsCallerId.new
      end
    end

    it 'returns an account id' do
      connection.stubs(:aws_client).returns(StsClient.new)
      connection.unique_identifier.must_equal '123456789012'
    end
  end
end
