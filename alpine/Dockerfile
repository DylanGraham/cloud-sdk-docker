FROM docker:19.03.11 as static-docker-source

FROM alpine:3.13
ARG GH_VERSION=1.9.2
ARG CLOUD_SDK_VERSION=347.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV PATH /google-cloud-sdk/bin:$PATH
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker
RUN addgroup -g 1000 -S cloudsdk && \
    adduser -u 1000 -S cloudsdk -G cloudsdk
RUN apk --no-cache add \
        curl \
        python3 \
        py3-crcmod \
        py3-openssl \
        bash \
        libc6-compat \
        openssh-client \
        git \
        less \
        gnupg \
	vim \
	openssl \
	ncurses \
	bash-completion \
	socat && \
	wget https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz && \
	tar xf gh_${GH_VERSION}_linux_amd64.tar.gz && \
	install -v gh_${GH_VERSION}_linux_amd64/bin/gh /usr/local/bin && \
	rm -rf gh_${GH_VERSION}_linux_amd64* && \
	curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
	tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
	rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
	gcloud config set core/disable_usage_reporting true && \
	gcloud config set component_manager/disable_update_check true && \
	gcloud config set metrics/environment github_docker_image && \
	gcloud --version && \
	gcloud components install kubectl alpha beta kpt --quiet && \
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
	chmod 700 get_helm.sh && \
	./get_helm.sh && \
	git clone https://github.com/ahmetb/kubectx.git ~/.kubectx && \
	ln -sf ~/.kubectx/kubens /usr/local/bin/kns && \
	ln -sf ~/.kubectx/kubectx /usr/local/bin/kctx
RUN git config --system credential.'https://source.developers.google.com'.helper gcloud.sh
VOLUME ["/root/.config"]
