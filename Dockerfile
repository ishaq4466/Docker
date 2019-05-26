# For  master jenkins
from jenkins/jenkins:2.164.3

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack

# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher

# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes
RUN /usr/local/bin/install-plugins.sh groovy

#ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV JENKINS_USERNAME="admin"
ENV JENKINS_PASSWORD="admin"
#JENKINS_HOME=""
#DISABLE_JENKINS_INITIALIZATION="no"



# install Maven
USER root
RUN apt-get update && apt-get install -y maven
RUN apt-get install -y net-tools iputils-ping
RUN apt-get install -y curl wget vim openssh-server sshpass
#RUN usermod -aG root jenkins
#RUN echo Done add>>>>>>><<<<<<
USER jenkins

