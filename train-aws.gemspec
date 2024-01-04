# As plugins are usually packaged and distributed as a RubyGem,
# we have to provide a .gemspec file, which controls the gembuild
# and publish process.  This is a fairly generic gemspec.

# It is traditional in a gemspec to dynamically load the current version
# from a file in the source tree.  The next three lines make that happen.
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "train-aws/version"

Gem::Specification.new do |spec|
  # Importantly, all Train plugins must be prefixed with `train-`
  spec.name          = "train-aws"

  # It is polite to namespace your plugin under InspecPlugins::YourPluginInCamelCase
  spec.version       = TrainPlugins::Aws::VERSION
  spec.authors       = ["Chef InSpec Team"]
  spec.email         = ["inspec@chef.io"]
  spec.summary       = "AWS API Transport for Train"
  spec.description   = "Allows applications using Train to speak to AWS; handles authentication, cacheing, and SDK dependency management."
  spec.homepage      = "https://github.com/inspec/train-aws"
  spec.license       = "Apache-2.0"

  # Though complicated-looking, this is pretty standard for a gemspec.
  # It just filters what will actually be packaged in the gem (leaving
  # out tests, etc)
  spec.files = %w{ LICENSE } + Dir.glob(
    "lib/**/*", File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
  spec.require_paths = ["lib"]

  # If you rely on any other gems, list them here with any constraints.
  # This is how `inspec plugin install` is able to manage your dependencies.

  # If you only need certain gems during development or testing, list
  # them in Gemfile, not here.

  # Do not list inspec as a dependency of a train plugin.
  # Do not list train as a dependency of a train plugin.

  # full version sync - 02 DEC 2023
  spec.add_dependency "aws-partitions", ">= 1.863", "< 1.878"
  spec.add_dependency "aws-sdk-account", "~> 1.20.0"
  spec.add_dependency "aws-sdk-accessanalyzer", "~> 1.44.0"
  # spec.add_dependency "aws-sdk-acm", "~> 1.64.0"
  # spec.add_dependency "aws-sdk-acmpca", "~> 1.63.0"
  spec.add_dependency "aws-sdk-alexaforbusiness", "~> 1.67.0"
  spec.add_dependency "aws-sdk-amplify", "~> 1.54.0"
  spec.add_dependency "aws-sdk-apigateway", "~> 1.90.0"
  # spec.add_dependency "aws-sdk-apigatewaymanagementapi", "~> 1.41.0"
  spec.add_dependency "aws-sdk-apigatewayv2", "~> 1.53.0"
  spec.add_dependency "aws-sdk-applicationautoscaling", "~> 1.79.0"
  # spec.add_dependency "aws-sdk-applicationdiscoveryservice", "~> 1.61.0"
  # spec.add_dependency "aws-sdk-applicationinsights", "~> 1.43.0"
  # spec.add_dependency "aws-sdk-appmesh", "~> 1.59.0"
  # spec.add_dependency "aws-sdk-appstream", "~> 1.82.0"
  # spec.add_dependency "aws-sdk-appsync", "~> 1.69.0"
  spec.add_dependency "aws-sdk-athena", ">= 1.78", "< 1.80"
  spec.add_dependency "aws-sdk-autoscaling", "1.102.0"
  # spec.add_dependency "aws-sdk-autoscalingplans", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-backup", "~> 1.63.0"
  spec.add_dependency "aws-sdk-batch", "~> 1.79.0"
  spec.add_dependency "aws-sdk-budgets", "~> 1.62.0"
  # spec.add_dependency "aws-sdk-chime", "~> 1.80.0"
  # spec.add_dependency "aws-sdk-cloud9", "~> 1.63.0"
  # spec.add_dependency "aws-sdk-clouddirectory", "~> 1.53.0"
  spec.add_dependency "aws-sdk-cloudformation", ">= 1.96", "< 1.98"
  spec.add_dependency "aws-sdk-cloudfront", "~> 1.86.0"
  spec.add_dependency "aws-sdk-cloudhsm", "~> 1.50.0"
  spec.add_dependency "aws-sdk-cloudhsmv2", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-cloudsearch", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-cloudsearchdomain", "~> 1.39.0"
  spec.add_dependency "aws-sdk-cloudtrail", "~> 1.74.0"
  spec.add_dependency "aws-sdk-cloudwatch", "~> 1.83.0"
  spec.add_dependency "aws-sdk-cloudwatchevents", "~> 1.69.0"
  spec.add_dependency "aws-sdk-cloudwatchlogs", "~> 1.75"
  # spec.add_dependency "aws-sdk-codebuild", "~> 1.100.0"
  spec.add_dependency "aws-sdk-codecommit", "~> 1.62.0"
  spec.add_dependency "aws-sdk-codedeploy", "~> 1.62.0"
  spec.add_dependency "aws-sdk-codepipeline", "~> 1.67.0"
  # spec.add_dependency "aws-sdk-codestar", "~> 1.49.0"
  spec.add_dependency "aws-sdk-cognitoidentity", "~> 1.51.0"
  spec.add_dependency "aws-sdk-cognitoidentityprovider", "~> 1.84"
  # spec.add_dependency "aws-sdk-cognitosync", "~> 1.47.0"
  # spec.add_dependency "aws-sdk-comprehend", "~> 1.77.0"
  # spec.add_dependency "aws-sdk-comprehendmedical", "~> 1.49.0"
  spec.add_dependency "aws-sdk-configservice", "~> 1.103.0"
  spec.add_dependency "aws-sdk-core", "~> 3.190.0"
  spec.add_dependency "aws-sdk-costandusagereportservice", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-costexplorer", "~> 1.94.0"
  spec.add_dependency "aws-sdk-databasemigrationservice", "~> 1.91.0"
  # spec.add_dependency "aws-sdk-datapipeline", "~> 1.47.0"
  # spec.add_dependency "aws-sdk-datasync", "~> 1.71.0"
  # spec.add_dependency "aws-sdk-dax", "~> 1.50.0"
  # spec.add_dependency "aws-sdk-devicefarm", "~> 1.63.0"
  # spec.add_dependency "aws-sdk-directconnect", "~> 1.68.0"
  # spec.add_dependency "aws-sdk-directoryservice", "~> 1.62.0"
  # spec.add_dependency "aws-sdk-dlm", "~> 1.67.0"
  # spec.add_dependency "aws-sdk-docdb", "~> 1.58.0"
  spec.add_dependency "aws-sdk-dynamodb", "~> 1.98.0"
  # spec.add_dependency "aws-sdk-dynamodbstreams", "~> 1.52.0"
  spec.add_dependency "aws-sdk-ec2", ">= 1.427", "< 1.430"
  # spec.add_dependency "aws-sdk-ec2instanceconnect", "~> 1.36.0"
  spec.add_dependency "aws-sdk-ecr", "~> 1.68.0"
  spec.add_dependency "aws-sdk-ecrpublic", "~> 1.25.0"
  spec.add_dependency "aws-sdk-ecs", "~> 1.135.0"
  spec.add_dependency "aws-sdk-efs", "~> 1.71.0"
  spec.add_dependency "aws-sdk-eks", "~> 1.95.0"
  spec.add_dependency "aws-sdk-elasticache", "~> 1.95.0"
  spec.add_dependency "aws-sdk-elasticbeanstalk", "~> 1.63.0"
  spec.add_dependency "aws-sdk-elasticloadbalancing", "~> 1.51.0"
  spec.add_dependency "aws-sdk-elasticloadbalancingv2", "~> 1.96.0"
  spec.add_dependency "aws-sdk-elasticsearchservice", "~> 1.79.0"
  # spec.add_dependency "aws-sdk-elastictranscoder", "~> 1.49.0"
  spec.add_dependency "aws-sdk-emr", "~> 1.81.0"
  spec.add_dependency "aws-sdk-eventbridge", "~> 1.54.0"
  spec.add_dependency "aws-sdk-firehose", "~> 1.60.0"
  # spec.add_dependency "aws-sdk-fms", "~> 1.66.0"
  # spec.add_dependency "aws-sdk-fsx", "~> 1.82.0"
  # spec.add_dependency "aws-sdk-gamelift", "~> 1.74.0"
  # spec.add_dependency "aws-sdk-glacier", "~> 1.58.0"
  # spec.add_dependency "aws-sdk-globalaccelerator", "~> 1.55.0"
  spec.add_dependency "aws-sdk-glue", "~> 1.164"
  # spec.add_dependency "aws-sdk-greengrass", "~> 1.62.0"
  # spec.add_dependency "aws-sdk-groundstation", "~> 1.43.0"
  spec.add_dependency "aws-sdk-guardduty", "~> 1.85.0"
  # spec.add_dependency "aws-sdk-health", "~> 1.59.0"
  spec.add_dependency "aws-sdk-iam", "~> 1.92.0"
  # spec.add_dependency "aws-sdk-importexport", "~> 1.42.0"
  # spec.add_dependency "aws-sdk-inspector", "~> 1.54.0"
  # spec.add_dependency "aws-sdk-iot", "~> 1.115.0"
  # spec.add_dependency "aws-sdk-iot1clickdevicesservice", "~> 1.48.0"
  # spec.add_dependency "aws-sdk-iot1clickprojects", "~> 1.48.0"
  # spec.add_dependency "aws-sdk-iotanalytics", "~> 1.60.0"
  # spec.add_dependency "aws-sdk-iotdataplane", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-iotevents", "~> 1.44.0"
  # spec.add_dependency "aws-sdk-ioteventsdata", "~> 1.38.0"
  # spec.add_dependency "aws-sdk-iotjobsdataplane", "~> 1.47.0"
  # spec.add_dependency "aws-sdk-iotthingsgraph", "~> 1.35.0"
  spec.add_dependency "aws-sdk-kafka", "~> 1.67.0"
  spec.add_dependency "aws-sdk-kinesis", "~> 1.54.0"
  # spec.add_dependency "aws-sdk-kinesisanalytics", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-kinesisanalyticsv2", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-kinesisvideo", "~> 1.58.0"
  # spec.add_dependency "aws-sdk-kinesisvideoarchivedmedia", "~> 1.55.0"
  # spec.add_dependency "aws-sdk-kinesisvideomedia", "~> 1.48.0"
  spec.add_dependency "aws-sdk-kms", "~> 1.74"
  spec.add_dependency "aws-sdk-lambda", "~> 1.113.0"
  # spec.add_dependency "aws-sdk-lambdapreview", "~> 1.42.0"
  # spec.add_dependency "aws-sdk-lex", "~> 1.56.0"
  # spec.add_dependency "aws-sdk-lexmodelbuildingservice", "~> 1.68.0"
  # spec.add_dependency "aws-sdk-licensemanager", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-lightsail", "~> 1.84.0"
  # spec.add_dependency "aws-sdk-machinelearning", "~> 1.49.0"
  spec.add_dependency "aws-sdk-macie2", "~> 1.64.0" 
  # spec.add_dependency "aws-sdk-managedblockchain", "~> 1.48.0"
  # spec.add_dependency "aws-sdk-marketplacecommerceanalytics", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-marketplaceentitlementservice", "~> 1.47.0"
  # spec.add_dependency "aws-sdk-marketplacemetering", "~> 1.55.0"
  # spec.add_dependency "aws-sdk-mediaconnect", "~> 1.56.0"
  # spec.add_dependency "aws-sdk-mediaconvert", "~> 1.122.0"
  # spec.add_dependency "aws-sdk-medialive", "~> 1.112.0"
  # spec.add_dependency "aws-sdk-mediapackage", "~> 1.69.0"
  # spec.add_dependency "aws-sdk-mediapackagevod", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-mediastore", "~> 1.52.0"
  # spec.add_dependency "aws-sdk-mediastoredata", "~> 1.49.0"
  # spec.add_dependency "aws-sdk-mediatailor", "~> 1.74.0"
  # spec.add_dependency "aws-sdk-migrationhub", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-mobile", "~> 1.46.0"
  spec.add_dependency "aws-sdk-mq", "~> 1.58.0"
  # spec.add_dependency "aws-sdk-mturk", "~> 1.51.0"
  # spec.add_dependency "aws-sdk-neptune", "~> 1.60.0"
  # spec.add_dependency "aws-sdk-opsworks", "~> 1.52.0"
  # spec.add_dependency "aws-sdk-opsworkscm", "~> 1.63.0"
  spec.add_dependency "aws-sdk-organizations", "~> 1.83.0"
  spec.add_dependency "aws-sdk-networkmanager", "~> 1.40.0"
  spec.add_dependency "aws-sdk-networkfirewall", "~> 1.39.0"
  # spec.add_dependency "aws-sdk-personalize", "~> 1.57.0"
  # spec.add_dependency "aws-sdk-personalizeevents", "~> 1.40.0"
  # spec.add_dependency "aws-sdk-personalizeruntime", "~> 1.45.0"
  # spec.add_dependency "aws-sdk-pi", "~> 1.52.0"
  # spec.add_dependency "aws-sdk-pinpoint", "~> 1.84.0"
  # spec.add_dependency "aws-sdk-pinpointemail", "~> 1.46.0"
  # spec.add_dependency "aws-sdk-pinpointsmsvoice", "~> 1.43.0"
  # spec.add_dependency "aws-sdk-polly", "~> 1.80.0"
  # spec.add_dependency "aws-sdk-pricing", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-quicksight", "~> 1.99.0"
  spec.add_dependency "aws-sdk-ram", "~> 1.52.0"
  spec.add_dependency "aws-sdk-rds", "~> 1.208.0"
  # spec.add_dependency "aws-sdk-rdsdataservice", "~> 1.49.0"
  spec.add_dependency "aws-sdk-redshift", "~> 1.107.0"
  # spec.add_dependency "aws-sdk-rekognition", "~> 1.91.0"
  # spec.add_dependency "aws-sdk-resourcegroups", "~> 1.57.0"
  # spec.add_dependency "aws-sdk-resourcegroupstaggingapi", "~> 1.58.0"
  # spec.add_dependency "aws-sdk-robomaker", "~> 1.62.0"
  spec.add_dependency "aws-sdk-route53", "~> 1.83.0"
  spec.add_dependency "aws-sdk-route53domains", "~> 1.54.0"
  spec.add_dependency "aws-sdk-route53resolver", "~> 1.51.0"
  spec.add_dependency "aws-sdk-s3", "~> 1.141.0"
  spec.add_dependency "aws-sdk-s3control", "~> 1.74.0"
  # spec.add_dependency "aws-sdk-sagemaker", "~> 1.224.0"
  # spec.add_dependency "aws-sdk-sagemakerruntime", "~> 1.60.0"
  spec.add_dependency "aws-sdk-secretsmanager", "~> 1.87.0"
  spec.add_dependency "aws-sdk-securityhub", "~> 1.98.0"
  # spec.add_dependency "aws-sdk-serverlessapplicationrepository", "~> 1.55.0"
  spec.add_dependency "aws-sdk-servicecatalog", "~> 1.90.0"
  # spec.add_dependency "aws-sdk-servicediscovery", "~> 1.61.0"
  # spec.add_dependency "aws-sdk-servicequotas", "~> 1.34.0"
  spec.add_dependency "aws-sdk-ses", "~> 1.58.0"
  spec.add_dependency "aws-sdk-shield", "~> 1.60.0"
  spec.add_dependency "aws-sdk-signer", "~> 1.50.0"
  spec.add_dependency "aws-sdk-simpledb", "~> 1.42.0"
  spec.add_dependency "aws-sdk-sms", "~> 1.52.0"
  # spec.add_dependency "aws-sdk-snowball", "~> 1.63.0"
  spec.add_dependency "aws-sdk-sns", "~> 1.70.0"
  spec.add_dependency "aws-sdk-sqs", "~> 1.69.0"
  spec.add_dependency "aws-sdk-ssm", "~> 1.162.0"
  spec.add_dependency "aws-sdk-states", "~> 1.63.0"
  # spec.add_dependency "aws-sdk-storagegateway", "~> 1.80.0"
  # spec.add_dependency "aws-sdk-support", "~> 1.54.0"
  # spec.add_dependency "aws-sdk-swf", "~> 1.49.0"
  spec.add_dependency "aws-sdk-synthetics", "~> 1.39.0"
  # spec.add_dependency "aws-sdk-textract", "~> 1.55.0"
  # spec.add_dependency "aws-sdk-transcribeservice", "~> 1.94.0"
  # spec.add_dependency "aws-sdk-transcribestreamingservice", "~> 1.56.0"
  spec.add_dependency "aws-sdk-transfer", "~> 1.86.0"
  # spec.add_dependency "aws-sdk-translate", "~> 1.62.0"
  spec.add_dependency "aws-sdk-waf", "~> 1.58.0"
  spec.add_dependency "aws-sdk-wafv2", "~> 1.74.0"
  # spec.add_dependency "aws-sdk-wafregional", "~> 1.59.0"
  # spec.add_dependency "aws-sdk-workdocs", "~> 1.53.0"
  # spec.add_dependency "aws-sdk-worklink", "~> 1.44.0"
  # spec.add_dependency "aws-sdk-workmail", "~> 1.62.0"
end
