#!/bin/bash

# The steps below have been replaced by docker-compose, so we can setup also MailHog.
# echo "Building container image jenkins-automated-demo..."
# docker build -t jenkins-automated-demo:latest setup/
# echo "Starting container jenkins-demo..."
# docker run -d \
#     --name jenkins-demo \
#     -p 8080:8080 \
#     -p 50000:50000 \
#     --restart=on-failure \
#     --env JAVA_OPTS="-Dhudson.footerURL=http://github.com/otaviokr -Djenkins.install.runSetupWizard=false" \
#     jenkins-automated-demo:latest

docker-compose up -d

sleep 5

until [ $(curl -LI --no-progress-meter http://localhost:8080/ -o /dev/null -w '%{http_code}\n') == "200" ]; do
    echo "Waiting Jenkins to become available..."
    sleep 5
done

echo "Adding file with secret (ansible vault password)..."
./setup/scripts/add_credential_file.sh

echo "Adding user/password credential (docker host)..."
./setup/scripts/add_credential_user.sh "$1" "$2"

echo "Configuring ansible-demo project job..."
./setup/scripts/configure_job.sh

echo "... done."
