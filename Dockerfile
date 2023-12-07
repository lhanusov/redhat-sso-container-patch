FROM openshift/sso76-openshift-rhel8:latest

USER root

ADD patch.zip /tmp/

RUN $JBOSS_HOME/bin/jboss-cli.sh --command="patch apply /tmp/patch.zip"
