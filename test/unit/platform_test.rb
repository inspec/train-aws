# This is a unit test for the AWS Train plugin
# Its job is to verify that platform detection is setup correctly.

# Include our test harness
require_relative "../helper"

# Load the class under test, the Connection definition.
# We're actually testig the Platform module, but it's exposed via the Connection.
require "train-aws/connection"

# Because InSpec is a Spec-style test suite, we're going to use MiniTest::Spec
# here, for familiar look and feel. However, this isn't InSpec (or RSpec) code.
describe TrainPlugins::Aws::Platform do
  it "should implement a platform method" do
    _(TrainPlugins::Aws::Platform.instance_methods(false)).must_include(:platform)
  end

  it "should force platform to 'aws'" do
    plat = TrainPlugins::Aws::Connection.new({}).platform
    _(plat.name).must_equal "aws"
    _(plat.linux?).must_equal false
    _(plat.cloud?).must_equal true
    _(plat.family).must_equal "cloud"
    _(plat.family_hierarchy).must_equal %w{cloud api}
  end

  it "provides api details in the platform data" do
    aws_version = Gem.loaded_specs["aws-sdk-core"].version
    aws_version = "aws-sdk-core: v#{aws_version}"
    plugin_version = "train-aws: v#{TrainPlugins::Aws::VERSION}"
    expected_release = "#{plugin_version}, #{aws_version}"
    plat = TrainPlugins::Aws::Connection.new({}).platform
    _(plat.release).must_equal expected_release
  end
end
