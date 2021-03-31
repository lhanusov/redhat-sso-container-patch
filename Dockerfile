FROM openshift/sso74-openshift-rhel8:latest

ADD patch.zip /tmp/

RUN $JBOSS_HOME/bin/jboss-cli.sh --command="patch apply /tmp/patch.zip"
