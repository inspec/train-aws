# train-aws - Train Plugin for connecting to AWS

* **Project State: Active**
* **Issues Response SLA: 3 business days**
* **Pull Request Response SLA: 3 business days**

For more information on project states and SLAs, see [this documentation](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md).

This plugin allows applications that rely on Train to communicate with the Amazon Web Services API.  For example, InSpec uses this to perform compliance checks against AWS infrastructure components.

The plugin is a wrapper around `aws-sdk-core` version 3, with additional service-specific gems added where needed by the `inspec-aws` resource pack.

Train itself has no CLI, nor a sophisticated test harness.  InSpec does have such facilities, so installing Train plugins will require an InSpec installation.  You do not need to use or understand InSpec.

Train plugins may be developed without an InSpec installation.

## To Install this as a User

Train plugins are distributed as gems.  You may choose to manage the gem yourself, but if you are an InSpec user, InSPec can handle it for you.

You will need InSpec v2.3 or later.

Simply run:

```
$ inspec plugin install train-aws
```

You can then run:

```
$ inspec detect -t aws://
== Platform Details

Name:      aws
Families:  cloud, api
Release:   train-aws: v0.1.0, aws-sdk-core: 3.30.0
Arch:      -
```

## Authenticating to AWS

These instructions assume you are using InSpec.

### Setting up AWS credentials for InSpec

InSpec uses the standard AWS authentication mechanisms. Typically, you will create an IAM user specifically for auditing activities.

* 1 Create an IAM user in the AWS console, with your choice of username. Check the box marked "Programmatic Access."
* 2 On the Permissions screen, choose Direct Attach. Select the AWS-managed IAM Profile named "ReadOnlyAccess." If you wish to restrict the user further, you may do so; see individual InSpec resources to identify which permissions are required.
* 3 After generating the key, record the Access Key ID and Secret Key.

#### Using Environment Variables to provide credentials

You may provide the credentials to InSpec by setting the following environment variables: `AWS_REGION`, `AWS_ACCESS_KEY_ID`, and `AWS_SECRET_KEY_ID`. You may also use `AWS_PROFILE`, or if you are using MFA, `AWS_SESSION_TOKEN`. See the [AWS Command Line Interface Docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) for details.

Once you have your environment variables set, you can verify your credentials by running:

```bash
you$ inspec detect -t aws://

== Platform Details
Name:      aws
Families:  cloud, api
Release:   aws-sdk-v2.10.125
```

#### Using the InSpec target option to provide credentials on AWS

Look for a file in your home directory named `~/.aws/credentials`. If it does not exist, create it. Choose a name for your profile; here, we're using the name 'auditing'. Add your credentials as a new profile, in INI format:

```bash
[auditing]
aws_access_key_id = AKIA....
aws_secret_access_key = 1234....abcd
```

You may now run InSpec using the `--target` / `-t` option, using the format `-t aws://region/profile`.  For example, to connect to the Ohio region using a profile named 'auditing', use `-t aws://us-east-2/auditing`.  Any omitted portion will use teh environment variables.

To verify your credentials,

```bash
you$ inspec detect -t aws://

== Platform Details
Name:      aws
Families:  cloud, api
Release:   aws-sdk-v2.10.125
```

## Reporting Issues

Bugs, typos, limitations, and frustrations are welcome to be reported through the [GitHub issues page for the train-aws project](https://github.com/inspec/train-aws/issues).

You may also ask questions in the #inspec channel of the CHef Community Slack team.  However, for an issue to get traction, please report it as a github issue.

## Development on this Plugin

### Development Process

If you wish to contribute to this plugin, please use the usual fork-branch-push-PR cycle.  All functional changes need new tests, and bugfixes are expected to include a new test that demonstrates the bug.

### Reference Information

[Plugin Development](https://github.com/inspec/train/blob/master/docs/dev/plugins.md) is documented on the `train` project on GitHub.

### Testing changes against AWS

Live-fire testing against AWS may be performed by the `integration` set of tests.  To run the integration tests, you will need to have a set of AWS credentials exported to your environment.  See test/integration/live_connect_test.rb .
