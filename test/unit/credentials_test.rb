# encoding: utf-8

# Because train-aws is an API-type plugin, and AWS requires credentials for
# most operations, the plugin must handle obtaining AWS credentials in various ways.

# Include our test harness
require "helper"

describe "AWS credential handling" do
  # Note: we re-declare test_options in several blocks
  let(:given_options) { nil }

  let(:transport) do
    ENV["AWS_REGION"] = "fixture_region_from_env"
    ENV["AWS_ACCESS_KEY_ID"] = "fixture_key_id_from_env"
    ENV["AWS_PROFILE"] = "fixture_profile_from_env"
    ENV["AWS_SECRET_ACCESS_KEY"] = "fixture_access_key_from_env"
    ENV["AWS_SESSION_TOKEN"] = "fixture_session_token_from_env"

    # need to load this here as it captures the envs on load
    load "train-aws/transport.rb"
    TrainPlugins::Aws::Transport.new(given_options)
  end

  let(:connection) { transport.connection }
  let(:observed_options) { connection.instance_variable_get(:@options) }
  let(:cache) { connection.instance_variable_get(:@cache) }

  describe "when no options provided" do
    it "defaults to env options" do
      observed_options[:region].must_equal "fixture_region_from_env"
      observed_options[:access_key_id].must_equal "fixture_key_id_from_env"
      observed_options[:profile].must_equal "fixture_profile_from_env"
      observed_options[:secret_access_key].must_equal "fixture_access_key_from_env"
      observed_options[:session_token].must_equal "fixture_session_token_from_env"
    end
  end

  describe "when given AWS-specific options" do
    let(:given_options) { { region: "overidden_region", access_key_id: "overidden_key" } }

    it "should override defaults when given options" do
      observed_options[:region].must_equal "overidden_region"
      observed_options[:access_key_id].must_equal "overidden_key"
      # These were not overridden
      observed_options[:profile].must_equal "fixture_profile_from_env"
      observed_options[:secret_access_key].must_equal "fixture_access_key_from_env"
      observed_options[:session_token].must_equal "fixture_session_token_from_env"
    end
  end

  describe "when parsing a URL" do
    let(:given_options) { { host: "region_from_url", path: "profile_from_url" } }

    it "should handle options resulting from a parsed URL" do
      # Train accepts target options in the form of URLs.
      # For AWS, the URI looks like:
      #  aws://region/profile_name
      # When Train.create is called and teh URL is parsed, Train exposes the
      # URI parts as a URL with host, path, etc.
      # train-aws takes those parsed pieces and re-labels them according
      # to AWS credential components.
      observed_options[:region].must_equal "region_from_url"
      observed_options[:profile].must_equal "profile_from_url"
      observed_options[:session_token].must_equal "fixture_session_token_from_env"
    end
  end

  # This seems to be sayig that we expect train-aws to *set* ENV vars,
  # which would be surprising.
  # describe 'connect' do
  #   it 'validate aws connection with profile' do
  #     observed_options[:profile] = 'xyz'
  #     ENV['AWS_PROFILE'].must_be_nil
  #     connection.connect
  #     ENV['AWS_PROFILE'].must_equal 'xyz'
  #   end

  #   it 'validate aws connection with region' do
  #     observed_options[:region] = 'xyz'
  #     ENV['AWS_REGION'].must_equal 'fixture_region'
  #     connection.connect
  #     ENV['AWS_REGION'].must_equal 'xyz'
  #   end
  # end
end
