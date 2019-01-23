#!/bin/bash
# Set any error to exit non-zero

if [[ $RUN_TESTS == "true" ]]; then

  apt-get update
  apt-get -y install jq

  set -e

  /usr/local/tomcat/bin/catalina.sh start
  while [ ! -f "/opt/lucee/web/logs/application.log" ] ; do sleep 2; done
  while [ ! -d "/opt/lucee/server/lucee-server/deploy" ] ; do sleep 2; done
  sleep 1

  wget -nv $TEST_RUNNER_URL -O $HOME/test-results.json
  TOTAL_PASSED=$(cat $HOME/test-results.json | jq -r '.totalPass')
  TOTAL_SKIPPED=$(cat $HOME/test-results.json | jq -r '.totalSkipped')
  TOTAL_FAILED=$(cat $HOME/test-results.json | jq -r '.totalFail')
  TOTAL_ERRORED=$(cat $HOME/test-results.json | jq -r '.totalError')

  echo "Total Passed:" $TOTAL_PASSED
  echo "Total Skipped:" $TOTAL_SKIPPED
  echo "Total Failed:" $TOTAL_FAILED
  echo "Total Errored:" $TOTAL_ERRORED

  if [[ $TOTAL_FAILED != "0" ]] || [[ $TOTAL_ERRORED != "0" ]]; then
    echo "Integration tests failed"
    cat $HOME/test-results.json | jq -r '.'
    exit 1
  fi

  /usr/local/tomcat/bin/catalina.sh stop
  rm -rf /opt/lucee/web/logs/*
  rm -rf $HOME/test-results.json

  echo "All tests completed successfully"

else

  echo "No tests ran"

fi
