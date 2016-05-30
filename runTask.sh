#!/bin/bash -x

if [[ -n "${GSGEN_DEBUG}" ]]; then set ${GSGEN_DEBUG}; fi

trap 'exit ${RESULT:-0}' EXIT SIGHUP SIGINT SIGTERM

BIN_DIR="${WORKSPACE}/${OAID}/config/bin"
cd ${WORKSPACE}/${OAID}/config/${PROJECT}/solutions/${ENVIRONMENT}

# Create the required task
${BIN_DIR}/runTask.sh -t "${TASK_TIER}" -i "${TASK_COMPONENT}" -w "${TASK_NAME}" -e "${TASK_ENV}" -v "${TASK_COMMAND}" 
RESULT=$?
if [[ ${RESULT} -ne 0 ]]; then
	echo "Running of task failed, exiting..."
	exit
fi

