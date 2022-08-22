#!/bin/bash

# This script creates a secret file in Jenkins credentials, using Jenkins API.

JENKINS_BASEURL="http://localhost:8080"
PROJECT="ansible-demo"
COOKIE_JAR_FILE="/tmp/cookies"

USERNAME=admin
PASSWORD=${USERNAME}

SECRET_FILE_PATH="${PWD}/setup/config/vault_pass.txt"
CREDENTIAL_ID="vault-password-file"
CREDENTIAL_DESC="Secret password to decrypt ansible vault files"
CREDENTIAL_JSON="{\"\": \"4\", \"credentials\": {\"file\": \"secret\", \"id\": \"${CREDENTIAL_ID}\", \"description\": \"${CREDENTIAL_DESC}\", \"stapler-class\": \"org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl\", \"\$class\": \"org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl\"}}"

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
    -F secret="@${SECRET_FILE_PATH}" \
    -F json="${CREDENTIAL_JSON}"
