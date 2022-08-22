#!/bin/bash

# This script creates an user/password credential in Jenkins credentials, using Jenkins API.

JENKINS_BASEURL="http://localhost:8080"
PROJECT="ansible-demo"
COOKIE_JAR_FILE="/tmp/cookies"

USERNAME=admin
PASSWORD=${USERNAME}

CREDENTIAL_ID="docker-host-credentials"
CREDENTIAL_USER="$1"
CREDENTIAL_PASS="$2"
CREDENTIAL_DESC="User and password to SSH to docker host (Jenkins is running in Docker, right?)"
CREDENTIAL_JSON="{\"\": \"0\", \"credentials\": {\"username\": \"${CREDENTIAL_USER}\", \"password\": \"${CREDENTIAL_PASS}\", \"id\": \"${CREDENTIAL_ID}\", \"description\": \"${CREDENTIAL_DESC}\", \"\$class\": \"com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl\"}}"

JENKINS_CRUMB=$(curl --no-progress-meter -u "${USERNAME}:${PASSWORD}" --cookie-jar ${COOKIE_JAR_FILE} "${JENKINS_BASEURL}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")

# For global credentials
CREATE_CREDENTIAL_URI="/credentials/store/system/domain/_/createCredentials"

# For a specific project
# CREATE_CREDENTIAL_URI="/job/${PROJECT}/credentials/store/folder/domain/_/createCredentials"

API_URL="${JENKINS_BASEURL}/${CREATE_CREDENTIAL_URI}"

curl --no-progress-meter \
    --cookie ${COOKIE_JAR_FILE} \
    -H ${JENKINS_CRUMB} \
    ${API_URL} \
    -u "${USERNAME}:${PASSWORD}" \
    -F "json=${CREDENTIAL_JSON}"
