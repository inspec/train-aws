# This is a unit test for the AWS Train plugin
# Its job is to verify that platform detection is setup correctly.

# Include our test harness
require_relative '../helper'

# Load the class under test, the Connection definition.
# We're actually testig the Platform module, but it's exposed via the Connection.
require 'train-aws/connection'

# Because InSpec is a Spec-style test suite, we're going to use MiniTest::Spec
# here, for familiar look and feel. However, this isn't InSpec (or RSpec) code.
describe TrainPlugins::Aws::Platform do
  it 'should implement a platform method' do
    TrainPlugins::Aws::Platform.instance_methods(false).must_include(:platform)
  end

  it "should force platform to 'aws'" do
    # TODO - don't know how to test this
  end
end
