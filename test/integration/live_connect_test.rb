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
require 'aws-sdk-core'

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

    skip "Bad ENV!" unless ORIG_AWS_ENV_VARS.size >= 4
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

    it 'works correctly using region and profile directly passed in' do
      transport = Train.create('aws', region: region, profile: profile)
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

  describe 'that access a variety of services via Clients' do
    # It is important to test each of these, since the gem depends on
    # each service on a gem-by-gem basis.  The Connection must load
    # all the services.
    {
      'cloudtrail' => { client: :CloudTrail, call: :describe_trails, duck: :trail_list },
      'cloudwatch' => {client: :CloudWatch, call: :describe_alarms, duck: :metric_alarms },
      'cloudwatchlogs' => {client: :CloudWatchLogs, call: :describe_log_groups, duck: :log_groups },
      'billing' => {client: :CostandUsageReportService, call: :describe_report_definitions, duck: :report_definitions },
      'config' => {client: :ConfigService, call: :describe_config_rules, duck: :config_rules },
      'ec2' => {client: :EC2, call: :describe_instances, duck: :reservations },
      'ecs' => {client: :ECS, call: :list_clusters, duck: :cluster_arns },
      'eks' => {client: :EKS, call: :list_clusters, duck: :clusters },
      'elb' => {client: :ElasticLoadBalancing, call: :describe_load_balancers, duck: :load_balancer_descriptions },
      'iam' => {client: :IAM, call: :list_groups, duck: :groups },
      'KMS' => {client: :KMS, call: :list_keys, duck: :keys },
      'RDS' => {client: :RDS, call: :describe_db_instances, duck: :db_instances },
      'S3' => {client: :S3, call: :list_buckets, duck: :buckets },
      'SQS' => {client: :SQS, call: :list_queues, duck: :queue_urls },
      'SNS' => {client: :SNS, call: :list_topics, duck: :topics },
    }.each do |service_name, test_args|
      it "should be able to access the '#{service_name}' service" do
        connection = Train.create('aws', region: region, profile: profile).connection
        service_module = ::Aws.const_get(test_args[:client])
        client_class = service_module.const_get(:Client)
        client = connection.aws_client(client_class)
        result = client.send(test_args[:call])
        result.must_respond_to test_args[:duck]
      end
    end
  end
end
