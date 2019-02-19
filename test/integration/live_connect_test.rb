# This test is like the functional tests in that it initializes
# a Connection object.  Unlike the functional tests, it uses the
# Connection to actually access AWS.

# To use this test, you must have in your ENV:
#  * AWS_ACCESS_KEY_ID
#  * AWS_SECRET_ACCESS_KEY
#  * AWS_PROFILE
#  * AWS_REGION
# These must be set to real values.

# To use this test, you must have in your ~/.aws/credentials:
#  * whatever profile you mention in the env var AWS_PROFILE

require 'train'
require_relative '../helper'

# On load, scrape all AWS_* ENV vars out and store them
# We'll re-inject them as needed
ORIG_AWS_ENV_VARS = ENV.keys.each_with_object({}) do |var_name, acc|
  if var_name.start_with?('AWS')
    acc[var_name] = ENV.delete(var_name)
  end
  acc
end

describe 'Live-fire conenctions to AWS' do
  # Purge ENV prior to each test
  before do
    ENV.delete_if { |var_name, _| var_name.start_with?('AWS') }
  end

  let(:key_id) {ORIG_AWS_ENV_VARS['AWS_ACCESS_KEY_ID']}
  let(:secret_key) {ORIG_AWS_ENV_VARS['AWS_SECRET_ACCESS_KEY']}
  let(:region) {ORIG_AWS_ENV_VARS['AWS_REGION']}
  let(:profile) {ORIG_AWS_ENV_VARS['AWS_PROFILE']}



  describe 'that use a variety of authentication methods' do
    let(:transport_options) { { backend: 'aws' } }
    let(:transport) { Train.create('aws', transport_options) }
    let(:connection) { transport.connection }
    let(:uuid) { connection.unique_identifier }

    # Common errors:
    # Aws::Errors::MissingCredentialsError Exception: unable to sign request without credentials set

    it 'works correctly using a target URI with region and profile' do
      transport_options = Train.unpack_target_from_uri("aws://#{region}/#{profile}")
      # TODO: figure out why memoizing these with let: breaks the test
      transport = Train.create('aws', transport_options)
      connection =  transport.connection
      uuid = connection.unique_identifier
      uuid.length.must_equal 12
    end

    it 'works correctly when the profile and region are in the ENV' do
      ENV['AWS_REGION'] = region
      ENV['AWS_PROFILE'] = profile
      uuid.length.must_equal 12
    end

    it 'works correctly when the key and region are in the ENV' do
      ENV['AWS_REGION'] = region
      ENV['AWS_ACCESS_KEY_ID'] = key_id
      ENV['AWS_SECRET_ACCESS_KEY'] = secret_key
      uuid.length.must_equal 12
    end

    # TODO: session key
  end

  describe 'that access a variety of services' do
    {
      # 'sts' => {client: '', call: '', check: ->{|r| true } },
    }.each do |service_name, test_args|
      it "should be ale to access the '#{service_name}' service" do
      end
    end
  end
end
