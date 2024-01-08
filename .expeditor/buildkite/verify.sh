#!/bin/bash

set -ueo pipefail

echo "--- system details"
uname -a
ruby -v
bundle --version

# Fetch tokens from vault ASAP so that long-running tests don't cause our vault token to expire
echo "--- installing vault"
export VAULT_VERSION=1.13.0
export VAULT_HOME=$HOME/vault
curl --create-dirs -sSLo $VAULT_HOME/vault.zip https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip
unzip -o $VAULT_HOME/vault.zip -d $VAULT_HOME

if [ -n "${CI_ENABLE_COVERAGE:-}" ]; then
  echo "--- fetching Sonar token from vault"
  export SONAR_TOKEN=$($VAULT_HOME/vault kv get -field token secret/inspec/train-aws/sonar)

  if [ -n "${SONAR_TOKEN:-}" ]; then
    echo "  ++ SONAR_TOKEN set successfully"
  else
    echo "  !! SONAR_TOKEN not set - exiting "
    exit 1 # TODO: Remove this line if we wish not to exit
  fi
fi

echo "--- bundle install"
bundle config set --local without tools maintenance deploy
bundle install --jobs=7 --retry=3

echo "+++ bundle exec rake"
bundle exec rake
RAKE_EXIT=$?

# If coverage is enabled, then we need to pick up the coverage/coverage.json file
if [ -n "${CI_ENABLE_COVERAGE:-}" ]; then
  echo "--- installing sonarscanner"
  export SONAR_SCANNER_VERSION=4.7.0.2747
  export SONAR_SCANNER_HOME=$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-linux
  curl --create-dirs -sSLo $HOME/.sonar/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip
  unzip -o $HOME/.sonar/sonar-scanner.zip -d $HOME/.sonar/
  export PATH=$SONAR_SCANNER_HOME/bin:$PATH
  export SONAR_SCANNER_OPTS="-server"

  # See sonar-project.properties for additional settings
  echo "--- running sonarscanner"
  sonar-scanner \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonar.progress.com
fi

exit $RAKE_EXIT
