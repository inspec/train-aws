# Test helper file for example Train plugins

# This file's job is to collect any libraries needed for testing, as well as provide
# any utilities to make testing a plugin easier.

# require 'train/plugin_test_helper'
require "minitest/spec"
require "minitest/mock"
require "mocha/minitest"
require "minitest/autorun"

class Module
  include Minitest::Spec::DSL
end

# Common debugging tools
require "pry"
require "byebug"
