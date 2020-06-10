FROM docker:19.03.11 as static-docker-source

FROM alpine:3.11
ARG CLOUD_SDK_VERSION=296.0.0
ENV HELM_VERSION v3.2.3
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV CLOUDSDK_PYTHON=python3

ENV PATH /google-cloud-sdk/bin:$PATH
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
RUN apk --no-cache add \
    curl \
    python3 \
    py3-crcmod \
    bash \
    libc6-compat \
    openssh-client \
    git \
    gnupg \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
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
RUN git config --system credential.'https://source.developers.google.com'.helper gcloud.sh
VOLUME ["/root/.config"]
