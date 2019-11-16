FROM docker:17.12.0-ce as static-docker-source

FROM alpine:3.10
ARG CLOUD_SDK_VERSION=271.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV HELM_VERSION v2.14.3

ENV PATH /google-cloud-sdk/bin:$PATH
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
ADD .bashrc /root/.bashrc
RUN apk --no-cache add \
    curl \
    python \
    py-crcmod \
    bash \
    libc6-compat \
    openssh-client \
    openssl \
    git \
    gnupg \
    bash-completion \
    ncurses && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    gcloud components install kubectl && \
    curl -LO https://git.io/get_helm.sh && \
    chmod +x get_helm.sh && \
    ./get_helm.sh --version ${HELM_VERSION} && \
    helm init --client-only && \
    git clone https://github.com/ahmetb/kubectx.git ~/.kubectx && \
    ln -sf ~/.kubectx/kubens /usr/local/bin/kns && \
    ln -sf ~/.kubectx/kubectx /usr/local/bin/kctx

VOLUME ["/root/.config"]
