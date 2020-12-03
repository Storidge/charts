FROM ubuntu
# Version is set with dummy default value, actually set via Makefile
LABEL maintainer="Storidge, Inc. <support@storidge.com>"
LABEL description="Container used to transfer storidge-config file to /etc/storidge/config"

RUN apt update && \
      apt install -y curl && \
      curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl

# Add run script
COPY run.sh /usr/bin/run.sh

# Add storidge-config template
COPY storidge-config /storidge/storidge-config

ENTRYPOINT ["sh", "/usr/bin/run.sh"]
