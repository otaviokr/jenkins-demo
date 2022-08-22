#!/bin/bash

# This script creates a new job, using Jenkins API.

JENKINS_BASEURL="http://localhost:8080"
PROJECT="ansible-demo"
COOKIE_JAR_FILE="/tmp/cookies"
CONFIG_XML_FILE="${PWD}/setup/config/config_ansible-demo.xml"

USERNAME=admin
PASSWORD=${USERNAME}

JENKINS_CRUMB=$(curl --no-progress-meter -u "${USERNAME}:${PASSWORD}" --cookie-jar ${COOKIE_JAR_FILE} "${JENKINS_BASEURL}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")

API_URL="${JENKINS_BASEURL}/createItem?name=${PROJECT}"

curl --no-progress-meter \
    --cookie ${COOKIE_JAR_FILE} \
    -H ${JENKINS_CRUMB} -H "Content-Type: application/xml" \
    ${API_URL} \
    -u "${USERNAME}:${PASSWORD}" \
    --data-binary "@${CONFIG_XML_FILE}"