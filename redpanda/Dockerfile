FROM debian:bullseye-slim

ARG APP_USER="redpanda"
ARG APP_GROUP="${APP_USER}"
ARG APP_UID="1000"
ARG APP_GID="${APP_UID}"
ARG APP_VERSION
ARG APP_DIR="/opt/redpanda"

ARG APP_URL="https://packages.vectorized.io"
ARG APP_REDPANDA_REPO
ARG APP_VERSION

ARG DEBIAN_FRONTEND=noninteractive

ENV PATH="${APP_DIR}/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install wget unzip curl apt-transport-https ca-certificates gnupg dnsutils gettext-base -y

RUN groupadd -g "${APP_GID}" "${APP_GROUP}" && \
    useradd -u "${APP_UID}" -g "${APP_GID}" -s /bin/bash -m -d "${APP_DIR}" "${APP_USER}"

WORKDIR /tmp

RUN wget "${APP_URL}/${APP_REDPANDA_REPO}/redpanda/cfg/setup/bash.deb.sh" -O repo.sh && \
    bash repo.sh && \
    apt-get download -o dir::cache::archives=. redpanda="${APP_VERSION}" && \
    dpkg-deb -R redpanda_"${APP_VERSION}"_amd64.deb tmp && \
    mkdir -p "${APP_DIR}"/{data,conf.d,coredump} && \
    mv tmp/opt/redpanda/bin "${APP_DIR}"/bin && \
    mv tmp/opt/redpanda/lib "${APP_DIR}"/lib && \
    mv tmp/opt/redpanda/libexec "${APP_DIR}"/libexec && \
    rm -rf tmp repo.sh redpanda_"${APP_VERSION}"_amd64.deb

WORKDIR "${APP_DIR}"

COPY ./entrypoint.sh .
COPY ./files/redpanda.yaml redpanda.yaml.tmp

RUN chown --recursive "${APP_USER}":"${APP_USER}" "${APP_DIR}"

USER "${APP_USER}"

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]