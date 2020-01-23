FROM rkrahl/opensuse:15.1

ARG VERSION

RUN zypper --non-interactive install \
        glibc-locale \
        gzip \
        tar \
        wget \
        && \
    ln -sf ../usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN groupadd -r -g 800 nodejs && \
    useradd -r -u 800 -g nodejs -c "Node.js" -d /usr/lib/nodejs nodejs && \
    mkdir -p /usr/lib/nodejs/bin
COPY bashrc /usr/lib/nodejs/.bashrc
COPY start.sh /usr/lib/nodejs/bin/start.sh
RUN chown -R nodejs:nodejs /usr/lib/nodejs

USER nodejs
WORKDIR /usr/lib/nodejs
ENV PATH /usr/lib/nodejs/bin:/usr/local/bin:/usr/bin:/bin
ENV NVM_DIR /usr/lib/nodejs/.nvm

RUN mkdir $NVM_DIR && \
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh \
        | bash && \
    bash -c ". .nvm/nvm.sh && nvm install $VERSION"

EXPOSE 3000
