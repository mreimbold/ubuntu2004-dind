ARG DOCKERIMAGE_TAG

FROM docker:${DOCKERIMAGE_TAG} as docker
FROM ubuntu:20.04

LABEL maintainer="Mirko Reimbold"

ENV ANSIBLE_USER=ansible SUDO_GROUP=sudo DOCKER_GROUP=docker DOCKER_TLS_CERTDIR=/certs

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    sudo \
    python3 \
    ca-certificates \
    iptables \
    openssl \
    pigz \
    xz-utils \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && groupadd -r ${ANSIBLE_USER} \
    && groupadd -r ${DOCKER_GROUP} \
    && useradd -m -g ${ANSIBLE_USER} ${ANSIBLE_USER} \
    && usermod -aG ${SUDO_GROUP} ${ANSIBLE_USER} \
    && usermod -aG ${DOCKER_GROUP} ${ANSIBLE_USER} \
    && sed -i "/^%${SUDO_GROUP}/s/ALL\$/NOPASSWD:ALL/g" /etc/sudoers

RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client

COPY --from=docker /usr/local/bin/ /usr/local/bin/

VOLUME /var/lib/docker

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
