#!/bin/bash

if [[ -n "${AUTOMATION_DEBUG}" ]]; then set ${AUTOMATION_DEBUG}; fi
trap 'exit ${RESULT:-1}' EXIT SIGHUP SIGINT SIGTERM

# Determine the required build image
cd ${WORKSPACE}/${ACCOUNT}/config/${PRODUCT}
BUILD_FILE="appsettings/${SEGMENT}/${SLICE}/build.ref"
if [[ -e ${BUILD_FILE} ]]; then
    BUILD_REFERENCE="$(cat ${BUILD_FILE})"
    echo "BUILD_REFERENCE=${BUILD_REFERENCE}" >> ${WORKSPACE}/context.properties
fi

# Generate the notification message information
if [[ -n "${BUILD_REFERENCE}" ]]; then
    echo "DETAIL_MESSAGE=${DETAIL_MESSAGE}, build=${BUILD_REFERENCE}" >> ${WORKSPACE}/context.properties
fi

# All good
RESULT=0
