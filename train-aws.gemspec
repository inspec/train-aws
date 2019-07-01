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
  spec.description   = "Allows applictaions using Train to speak to AWS; handles authentication, cacheing, and SDK dependency management."
  spec.homepage      = "https://github.com/inspec/train-aws"
  spec.license       = "Apache-2.0"

  # Though complicated-looking, this is pretty standard for a gemspec.
  # It just filters what will actually be packaged in the gem (leaving
  # out tests, etc)
  spec.files = %w{
    README.md train-aws.gemspec Gemfile
  } + Dir.glob(
    "lib/**/*", File::FNM_DOTMATCH
  ).reject { |f| File.directory?(f) }
  spec.require_paths = ["lib"]

  # If you rely on any other gems, list them here with any constraints.
  # This is how `inspec plugin install` is able to manage your dependencies.

  # If you only need certain gems during development or testing, list
  # them in Gemfile, not here.

  # Do not list inspec as a dependency of a train plugin.

  spec.add_dependency "train", "~> 2.0"
  spec.add_dependency "aws-sdk-autoscaling", "~> 1.22.0"
  spec.add_dependency "aws-sdk-cloudtrail", "~> 1.8"
  spec.add_dependency "aws-sdk-cloudwatch", "~> 1.13"
  spec.add_dependency "aws-sdk-cloudwatchlogs", "~> 1.13"
  spec.add_dependency "aws-sdk-configservice", "~> 1.21"
  spec.add_dependency "aws-sdk-core", "~> 3.0"
  spec.add_dependency "aws-sdk-costandusagereportservice", "~> 1.6"
  spec.add_dependency "aws-sdk-dynamodb", "~> 1.31"
  spec.add_dependency "aws-sdk-ec2", "~> 1.70"
  spec.add_dependency "aws-sdk-ecr", "~> 1.18"
  spec.add_dependency "aws-sdk-ecs", "~> 1.30"
  spec.add_dependency "aws-sdk-eks", "~> 1.9"
  spec.add_dependency "aws-sdk-elasticloadbalancing", "~> 1.8"
  spec.add_dependency "aws-sdk-iam", "~> 1.13"
  spec.add_dependency "aws-sdk-kms", "~> 1.13"
  spec.add_dependency "aws-sdk-organizations", "~> 1.17.0"
  spec.add_dependency "aws-sdk-rds", "~> 1.43"
  spec.add_dependency "aws-sdk-s3", "~> 1.30"
  spec.add_dependency "aws-sdk-sns", "~> 1.9"
  spec.add_dependency "aws-sdk-sqs", "~> 1.10"
end
