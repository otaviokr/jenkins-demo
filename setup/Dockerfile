FROM jenkins/jenkins:lts-jdk11

USER root

RUN apt-get update && \
    apt-get install -y ansible sshpass

USER jenkins

ENV JAVA_OPTS "-Dhudson.footerURL=http://github.com/otaviokr -Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc_configs

RUN mkdir -p ${CASC_JENKINS_CONFIG}

COPY --chown=jenkins:jenkins config/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY --chown=jenkins:jenkins config/jenkins_casc.yml ${CASC_JENKINS_CONFIG}/jenkins_casc.yml

RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
