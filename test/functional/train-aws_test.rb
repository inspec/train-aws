# Functional tests for train-aws

# Functional tests are used to verify the behaviors of the plugin are as
# expected, to a user.

# For train, a "user" is a developer using your plugin to access things from
# their app. Unlike unit tests, we don't assume any knowledge of how anything
# works; we just know what it is supposed to do.

# Include our test harness
require_relative '../helper'

# Because InSpec is a Spec-style test suite, and Train has a close relationship
# to InSpec, we're going to use MiniTest::Spec here, for familiar look and
# feel. However, this isn't InSpec (or RSpec) code.
describe 'train-aws' do
  # Our helper.rb locates this library from the Train install that
  # Bundler installed for us. If we want its methods, we still must
  # import it.  Including it here will make it available in all child
  # 'describe' blocks.
  include TrainPluginFunctionalHelper

  # When thinking up scenarios to test, start with the simplest.
  # Then think of each major feature, and exercise them.
  # Running combinations of features makes sense if it is very likely,
  # or a difficult / dangerous case.  You can always add more tests
  # here as users find subtle problems.  In fact, having a user submit
  # a PR that creates a failing functional test is a great way to
  # capture the reproduction case.

  # Some tests through here use minitest Expectations, which attach to all
  # Objects, and begin with 'must' (positive) or 'wont' (negative)
  # See https://ruby-doc.org/stdlib-2.1.0/libdoc/minitest/rdoc/MiniTest/Expectations.html

  describe "creating a train instance with this transport" do
    # This is a bit of an awkward test. There is no 'wont_raise', so
    # we just execute the risky code; if it breaks, the test will be
    # registered as an Error.

    it "should not explode on create" do
      # This checks for uncaught exceptions.
      Train.create('aws')

      # This checks for warnings (or any other output) to stdout/stderr
      proc { Train.create('aws') }.must_be_silent
    end
  end

  describe 'connecting using the transport'

    it "should not explode on connect" do
      # This checks for uncaught exceptions.
      Train.create('aws').connection

      # This checks for warnings (or any other output) to stdout/stderr
      proc { Train.create('aws').connection }.must_be_silent
    end
  end

  describe "reading a file" do
    it "should throw an exception if you try to read a file" do
      conn = Train.create('aws').connection
      path = File.join(plugin_fixtures_path, 'nonesuch')
      proc { conn.file(path).contents }.must_raise(NotImplementedError)
    end
  end

  describe "running a command" do
    it "should throw an exception if you try to run a command" do
      conn = Train.create('aws').connection
      proc { conn.run_command('date') }.must_raise(NotImplementedError)
    end
  end
end
