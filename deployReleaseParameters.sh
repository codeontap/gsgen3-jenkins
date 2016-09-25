#!/bin/bash

if [[ -n "${GSGEN_DEBUG}" ]]; then set ${GSGEN_DEBUG}; fi

trap 'exit ${RESULT:-1}' EXIT SIGHUP SIGINT SIGTERM

# Ensure DEPLOYMENT_NUMBER have been provided
if [[ "${DEPLOYMENT_NUMBER}" == "" ]]; then
	echo "Job requires the deployment number, exiting..."
    RESULT=1
    exit
fi

# Ensure at least one slice has been provided
if [[ ( -z "${SLICE}" ) && ( -z "${SLICES}" ) ]]; then
	echo "Job requires at least one slice, exiting..."
    RESULT=1
    exit
fi

# Don't forget -c ${DEPLOYMENT_TAG} -i ${DEPLOYMENT_TAG} on constructTree.sh

# All good
RESULT=0

