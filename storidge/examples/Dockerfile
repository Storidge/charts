FROM nginx
# Version is set with dummy default value, actually set via Makefile
LABEL maintainer="Storidge, Inc. <support@storidge.com>"
LABEL description="Container used to transfer storidge-config file to /etc/storidge/config"

# Add run script
COPY run.sh /usr/bin/run.sh

ENTRYPOINT ["sh", "/usr/bin/run.sh"]

