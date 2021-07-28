#!/bin/bash

# get coverage for this pipeline
latest=`curl --header "PRIVATE-TOKEN: ${COVERAGE_PAT}" -s https://gitlab-dev.bespinmobile.cloud/api/v4/projects/${CI_PROJECT_ID}/pipelines/${CI_PIPELINE_ID} | jq '.coverage'`
latest="${latest%\"}"
latest="${latest#\"}"
latest="${latest/.*}"
echo "pipline " ${CI_PIPELINE_ID} " coverage = " $latest

# get coverage for latest successful pipeline on develop
tmp=`curl --header "PRIVATE-TOKEN: ${COVERAGE_PAT}" -s https://gitlab-dev.bespinmobile.cloud/api/v4/projects/${CI_PROJECT_ID}/pipelines\?ref\=develop\&status\=success | jq '.[0] | .id'`
develop=`curl --header "PRIVATE-TOKEN: ${COVERAGE_PAT}" -s https://gitlab-dev.bespinmobile.cloud/api/v4/projects/${CI_PROJECT_ID}/pipelines/${tmp} | jq '.coverage'`
develop="${develop%\"}"
develop="${develop#\"}"
develop="${develop/.*}"
echo "develop coverage value =" $develop

# set develop to 0 if null
if [ "$develop" = "null" ]
then
  develop="0"
fi

# if latest >= 70 exit 0
if [ "$latest" -ge 70 ]
then
  echo "Latest pipeline coverage >= 70%"
  exit 0
# else fail
else
  echo "Latest pipeline coverage < 70%"
  exit 1
fi
