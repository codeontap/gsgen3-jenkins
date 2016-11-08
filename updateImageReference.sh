#!/bin/bash

if [[ -n "${GSGEN_DEBUG}" ]]; then set ${GSGEN_DEBUG}; fi
JENKINS_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
trap 'exit ${RESULT:-1}' EXIT SIGHUP SIGINT SIGTERM

# Check the current reference value
cd ${WORKSPACE}/${AID}/config/${PRODUCT}
BUILD_FILE="appsettings/${SEGMENT}/${SLICE}/build.ref"
if [[ "$(cat ${BUILD_FILE})" == "${GIT_COMMIT}" ]]; then
  echo "The current reference is the same, exiting..."
  RESULT=1
  exit
fi

echo ${GIT_COMMIT} > ${BUILD_FILE}

${JENKINS_DIR}/manageRepo.sh -p \
    -d . \
    -n config \
    -m "Change build.ref for ${SEGMENT}/${SLICE} to the value: ${GIT_COMMIT}" \
    -b ${PRODUCT_CONFIG_REFERENCE}

if [[ "$AUTODEPLOY" != "true" ]]; then
  echo "AUTODEPLOY is not true, triggering exit ..."
  RESULT=2
  exit
fi

# All good
RESULT=0


