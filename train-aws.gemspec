# As plugins are usually packaged and distributed as a RubyGem,
# we have to provide a .gemspec file, which controls the gembuild
# and publish process.  This is a fairly generic gemspec.

# It is traditional in a gemspec to dynamically load the current version
# from a file in the source tree.  The next three lines make that happen.
lib = File.expand_path("../lib", __FILE__)
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

  # spec.add_dependency "aws-sdk-acm", "~> 1.0"
  # spec.add_dependency "aws-sdk-acmpca", "~> 1.0"
  # spec.add_dependency "aws-sdk-alexaforbusiness", "~> 1.0"
  # spec.add_dependency "aws-sdk-amplify", "~> 1.0"
  spec.add_dependency "aws-sdk-apigateway", "~> 1.0"
  # spec.add_dependency "aws-sdk-apigatewaymanagementapi", "~> 1.0"
  spec.add_dependency "aws-sdk-apigatewayv2", "~> 1.0"
  # spec.add_dependency "aws-sdk-applicationautoscaling", "~> 1.0"
  # spec.add_dependency "aws-sdk-applicationdiscoveryservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-applicationinsights", "~> 1.0"
  # spec.add_dependency "aws-sdk-appmesh", "~> 1.0"
  # spec.add_dependency "aws-sdk-appstream", "~> 1.0"
  # spec.add_dependency "aws-sdk-appsync", "~> 1.0"
  spec.add_dependency "aws-sdk-athena", "~> 1.0"
  spec.add_dependency "aws-sdk-autoscaling", "~> 1.22.0"
  # spec.add_dependency "aws-sdk-autoscalingplans", "~> 1.0"
  # spec.add_dependency "aws-sdk-backup", "~> 1.0"
  # spec.add_dependency "aws-sdk-batch", "~> 1.0"
  spec.add_dependency "aws-sdk-budgets", "~> 1.0"
  # spec.add_dependency "aws-sdk-chime", "~> 1.0"
  # spec.add_dependency "aws-sdk-cloud9", "~> 1.0"
  # spec.add_dependency "aws-sdk-clouddirectory", "~> 1.0"
  spec.add_dependency "aws-sdk-cloudformation", "~> 1.0"
  spec.add_dependency "aws-sdk-cloudfront", "~> 1.0"
  spec.add_dependency "aws-sdk-cloudhsm", "~> 1.0"
  spec.add_dependency "aws-sdk-cloudhsmv2", "~> 1.0"
  # spec.add_dependency "aws-sdk-cloudsearch", "~> 1.0"
  # spec.add_dependency "aws-sdk-cloudsearchdomain", "~> 1.0"
  spec.add_dependency "aws-sdk-cloudtrail", "~> 1.8"
  spec.add_dependency "aws-sdk-cloudwatch", "~> 1.13"
  # spec.add_dependency "aws-sdk-cloudwatchevents", "~> 1.0"
  spec.add_dependency "aws-sdk-cloudwatchlogs", "~> 1.13"
  # spec.add_dependency "aws-sdk-codebuild", "~> 1.0"
  spec.add_dependency "aws-sdk-codecommit", "~> 1.0"
  spec.add_dependency "aws-sdk-codedeploy", "~> 1.0"
  spec.add_dependency "aws-sdk-codepipeline", "~> 1.0"
  # spec.add_dependency "aws-sdk-codestar", "~> 1.0"
  # spec.add_dependency "aws-sdk-cognitoidentity", "~> 1.0"
  # spec.add_dependency "aws-sdk-cognitoidentityprovider", "~> 1.0"
  # spec.add_dependency "aws-sdk-cognitosync", "~> 1.0"
  # spec.add_dependency "aws-sdk-comprehend", "~> 1.0"
  # spec.add_dependency "aws-sdk-comprehendmedical", "~> 1.0"
  spec.add_dependency "aws-sdk-configservice", "~> 1.21"
  spec.add_dependency "aws-sdk-core", "~> 3.0"
  spec.add_dependency "aws-sdk-costandusagereportservice", "~> 1.6"
  # spec.add_dependency "aws-sdk-costexplorer", "~> 1.0"
  # spec.add_dependency "aws-sdk-databasemigrationservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-datapipeline", "~> 1.0"
  # spec.add_dependency "aws-sdk-datasync", "~> 1.0"
  # spec.add_dependency "aws-sdk-dax", "~> 1.0"
  # spec.add_dependency "aws-sdk-devicefarm", "~> 1.0"
  # spec.add_dependency "aws-sdk-directconnect", "~> 1.0"
  # spec.add_dependency "aws-sdk-directoryservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-dlm", "~> 1.0"
  # spec.add_dependency "aws-sdk-docdb", "~> 1.0"
  spec.add_dependency "aws-sdk-dynamodb", "~> 1.31"
  # spec.add_dependency "aws-sdk-dynamodbstreams", "~> 1.0"
  spec.add_dependency "aws-sdk-ec2", "~> 1.70"
  # spec.add_dependency "aws-sdk-ec2instanceconnect", "~> 1.0"
  spec.add_dependency "aws-sdk-ecr", "~> 1.18"
  spec.add_dependency "aws-sdk-ecs", "~> 1.30"
  spec.add_dependency "aws-sdk-efs", "~> 1.0"
  spec.add_dependency "aws-sdk-eks", "~> 1.9"
  spec.add_dependency "aws-sdk-elasticache", "~> 1.0"
  spec.add_dependency "aws-sdk-elasticbeanstalk", "~> 1.0"
  spec.add_dependency "aws-sdk-elasticloadbalancing", "~> 1.8"
  spec.add_dependency "aws-sdk-elasticloadbalancingv2", "~> 1.0"
  spec.add_dependency "aws-sdk-elasticsearchservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-elastictranscoder", "~> 1.0"
  # spec.add_dependency "aws-sdk-emr", "~> 1.0"
  spec.add_dependency "aws-sdk-firehose", "~> 1.0"
  # spec.add_dependency "aws-sdk-fms", "~> 1.0"
  # spec.add_dependency "aws-sdk-fsx", "~> 1.0"
  # spec.add_dependency "aws-sdk-gamelift", "~> 1.0"
  # spec.add_dependency "aws-sdk-glacier", "~> 1.0"
  # spec.add_dependency "aws-sdk-globalaccelerator", "~> 1.0"
  # spec.add_dependency "aws-sdk-glue", "~> 1.0"
  # spec.add_dependency "aws-sdk-greengrass", "~> 1.0"
  # spec.add_dependency "aws-sdk-groundstation", "~> 1.0"
  # spec.add_dependency "aws-sdk-guardduty", "~> 1.0"
  # spec.add_dependency "aws-sdk-health", "~> 1.0"
  spec.add_dependency "aws-sdk-iam", "~> 1.13"
  # spec.add_dependency "aws-sdk-importexport", "~> 1.0"
  # spec.add_dependency "aws-sdk-inspector", "~> 1.0"
  # spec.add_dependency "aws-sdk-iot", "~> 1.0"
  # spec.add_dependency "aws-sdk-iot1clickdevicesservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-iot1clickprojects", "~> 1.0"
  # spec.add_dependency "aws-sdk-iotanalytics", "~> 1.0"
  # spec.add_dependency "aws-sdk-iotdataplane", "~> 1.0"
  # spec.add_dependency "aws-sdk-iotevents", "~> 1.0"
  # spec.add_dependency "aws-sdk-ioteventsdata", "~> 1.0"
  # spec.add_dependency "aws-sdk-iotjobsdataplane", "~> 1.0"
  # spec.add_dependency "aws-sdk-iotthingsgraph", "~> 1.0"
  spec.add_dependency "aws-sdk-kafka", "~> 1.0"
  spec.add_dependency "aws-sdk-kinesis", "~> 1.0"
  # spec.add_dependency "aws-sdk-kinesisanalytics", "~> 1.0"
  # spec.add_dependency "aws-sdk-kinesisanalyticsv2", "~> 1.0"
  # spec.add_dependency "aws-sdk-kinesisvideo", "~> 1.0"
  # spec.add_dependency "aws-sdk-kinesisvideoarchivedmedia", "~> 1.0"
  # spec.add_dependency "aws-sdk-kinesisvideomedia", "~> 1.0"
  spec.add_dependency "aws-sdk-kms", "~> 1.13"
  spec.add_dependency "aws-sdk-lambda", "~> 1.0"
  # spec.add_dependency "aws-sdk-lambdapreview", "~> 1.0"
  # spec.add_dependency "aws-sdk-lex", "~> 1.0"
  # spec.add_dependency "aws-sdk-lexmodelbuildingservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-licensemanager", "~> 1.0"
  # spec.add_dependency "aws-sdk-lightsail", "~> 1.0"
  # spec.add_dependency "aws-sdk-machinelearning", "~> 1.0"
  # spec.add_dependency "aws-sdk-macie", "~> 1.0"
  # spec.add_dependency "aws-sdk-managedblockchain", "~> 1.0"
  # spec.add_dependency "aws-sdk-marketplacecommerceanalytics", "~> 1.0"
  # spec.add_dependency "aws-sdk-marketplaceentitlementservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-marketplacemetering", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediaconnect", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediaconvert", "~> 1.0"
  # spec.add_dependency "aws-sdk-medialive", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediapackage", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediapackagevod", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediastore", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediastoredata", "~> 1.0"
  # spec.add_dependency "aws-sdk-mediatailor", "~> 1.0"
  # spec.add_dependency "aws-sdk-migrationhub", "~> 1.0"
  # spec.add_dependency "aws-sdk-mobile", "~> 1.0"
  # spec.add_dependency "aws-sdk-mq", "~> 1.0"
  # spec.add_dependency "aws-sdk-mturk", "~> 1.0"
  # spec.add_dependency "aws-sdk-neptune", "~> 1.0"
  # spec.add_dependency "aws-sdk-opsworks", "~> 1.0"
  # spec.add_dependency "aws-sdk-opsworkscm", "~> 1.0"
  spec.add_dependency "aws-sdk-organizations", ">= 1.17", "< 1.44"
  # spec.add_dependency "aws-sdk-personalize", "~> 1.0"
  # spec.add_dependency "aws-sdk-personalizeevents", "~> 1.0"
  # spec.add_dependency "aws-sdk-personalizeruntime", "~> 1.0"
  # spec.add_dependency "aws-sdk-pi", "~> 1.0"
  # spec.add_dependency "aws-sdk-pinpoint", "~> 1.0"
  # spec.add_dependency "aws-sdk-pinpointemail", "~> 1.0"
  # spec.add_dependency "aws-sdk-pinpointsmsvoice", "~> 1.0"
  # spec.add_dependency "aws-sdk-polly", "~> 1.0"
  # spec.add_dependency "aws-sdk-pricing", "~> 1.0"
  # spec.add_dependency "aws-sdk-quicksight", "~> 1.0"
  # spec.add_dependency "aws-sdk-ram", "~> 1.0"
  spec.add_dependency "aws-sdk-rds", "~> 1.43"
  # spec.add_dependency "aws-sdk-rdsdataservice", "~> 1.0"
  spec.add_dependency "aws-sdk-redshift", "~> 1.0"
  # spec.add_dependency "aws-sdk-rekognition", "~> 1.0"
  # spec.add_dependency "aws-sdk-resourcegroups", "~> 1.0"
  # spec.add_dependency "aws-sdk-resourcegroupstaggingapi", "~> 1.0"
  # spec.add_dependency "aws-sdk-robomaker", "~> 1.0"
  spec.add_dependency "aws-sdk-route53", "~> 1.0"
  spec.add_dependency "aws-sdk-route53domains", "~> 1.0"
  spec.add_dependency "aws-sdk-route53resolver", "~> 1.0"
  spec.add_dependency "aws-sdk-s3", "~> 1.30"
  # spec.add_dependency "aws-sdk-s3control", "~> 1.0"
  # spec.add_dependency "aws-sdk-sagemaker", "~> 1.0"
  # spec.add_dependency "aws-sdk-sagemakerruntime", "~> 1.0"
  # spec.add_dependency "aws-sdk-secretsmanager", "~> 1.0"
  spec.add_dependency "aws-sdk-securityhub", "~> 1.0"
  # spec.add_dependency "aws-sdk-serverlessapplicationrepository", "~> 1.0"
  # spec.add_dependency "aws-sdk-servicecatalog", "~> 1.0"
  # spec.add_dependency "aws-sdk-servicediscovery", "~> 1.0"
  # spec.add_dependency "aws-sdk-servicequotas", "~> 1.0"
  spec.add_dependency "aws-sdk-ses", "~> 1.0"
  # spec.add_dependency "aws-sdk-shield", "~> 1.0"
  # spec.add_dependency "aws-sdk-signer", "~> 1.0"
  # spec.add_dependency "aws-sdk-simpledb", "~> 1.0"
  spec.add_dependency "aws-sdk-sms", "~> 1.0"
  # spec.add_dependency "aws-sdk-snowball", "~> 1.0"
  spec.add_dependency "aws-sdk-sns", "~> 1.9"
  spec.add_dependency "aws-sdk-sqs", "~> 1.10"
  spec.add_dependency "aws-sdk-ssm", "~> 1.0"
  # spec.add_dependency "aws-sdk-states", "~> 1.0"
  # spec.add_dependency "aws-sdk-storagegateway", "~> 1.0"
  # spec.add_dependency "aws-sdk-support", "~> 1.0"
  # spec.add_dependency "aws-sdk-swf", "~> 1.0"
  # spec.add_dependency "aws-sdk-textract", "~> 1.0"
  # spec.add_dependency "aws-sdk-transcribeservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-transcribestreamingservice", "~> 1.0"
  # spec.add_dependency "aws-sdk-transfer", "~> 1.0"
  # spec.add_dependency "aws-sdk-translate", "~> 1.0"
  # spec.add_dependency "aws-sdk-waf", "~> 1.0"
  # spec.add_dependency "aws-sdk-wafregional", "~> 1.0"
  # spec.add_dependency "aws-sdk-workdocs", "~> 1.0"
  # spec.add_dependency "aws-sdk-worklink", "~> 1.0"
  # spec.add_dependency "aws-sdk-workmail", "~> 1.0"
end
