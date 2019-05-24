# Functional tests for train-aws

# Functional tests are used to verify the behaviors of the plugin are as
# expected, to a user.

# For train, a "user" is a developer using your plugin to access things from
# their app. Unlike unit tests, we don't assume any knowledge of how anything
# works; we just know what it is supposed to do.

require_relative "../helper"
require "train"

# Train should auto-load train-aws
# require 'train-aws'

describe "train-aws" do
  describe "creating a train instance with this transport" do
    it "should not explode on create" do
      # This checks for uncaught exceptions.
      Train.create("aws", {})

      # This checks for warnings (or any other output) to stdout/stderr
      proc { Train.create("aws") }.must_be_silent
    end
  end

  describe "creating a connection object using the transport" do
    it "should not explode on connect" do
      # This checks for uncaught exceptions.
      Train.create("aws").connection

      # This checks for warnings (or any other output) to stdout/stderr
      proc { Train.create("aws").connection }.must_be_silent
    end
  end

  describe "reading a file" do
    it "should throw an exception if you try to read a file" do
      conn = Train.create("aws").connection
      path = File.join("nonesuch" + rand.to_s)
      proc { conn.file(path).contents }.must_raise(NotImplementedError)
    end
  end

  describe "running a command" do
    it "should throw an exception if you try to run a command" do
      conn = Train.create("aws").connection
      proc { conn.run_command("date") }.must_raise(NotImplementedError)
    end
  end
end
