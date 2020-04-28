FROM alpine:3.7

WORKDIR /workspace

ARG HELM_VERSION=2.14.3
ARG KUBECTL_VERSION=1.16.1

ENV PACKAGES="git curl ca-certificates"

RUN apk add --update --no-cache $PACKAGES && \
    curl -L https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    helm version --client && \
    rm -rf linux-amd64 && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/kubectl && \
    kubectl version --client=true && \
    rm -f /var/cache/apk/*

ENTRYPOINT ["/bin/sh"]
