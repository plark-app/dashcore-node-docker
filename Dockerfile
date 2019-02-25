FROM node:11.10-slim

RUN apt-get update && \
  apt-get install -y \
      g++ \
      make \
      python \
      gettext-base \
      jq \
      patch \
  && \
  wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb && \
  dpkg -i dumb-init_*.deb && \
  rm -rf \
    dumb-init_*.deb \
    /var/lib/apt/lists/* \
  && \
  apt-get autoclean && \
  apt-get autoremove -y

WORKDIR /root/dash-node
COPY dashcore-node/package.json ./

RUN npm config set package-lock false && \
  npm install && \
  apt-get purge -y g++ make python gcc && \
  apt-get autoclean && \
  apt-get autoremove -y && \
  rm -rf \
      node_modules/@dashevo/dashcore-node/test \
      /root/.npm \
      /root/.node-gyp \
      /tmp/*

COPY dashcore-node/logo-insight-dash.patch ./
RUN cat logo-insight-dash.patch | patch -l -p1 -d node_modules/@dashevo/insight-ui

COPY dashcore-node/dashcore-node.template.json ./
COPY dashcore-node/dashcore-start.sh ./

EXPOSE 3001

ENV DASH_TESTNET=0 \
    DASH_RPC_HOST=127.0.0.1 \
    DASH_RPC_PORT=9998 \
    DASH_RPC_USER="dash" \
    DASH_RPC_PASSWORD="dash" \
    DASH_ZMQ_HOST="" \
    DASH_ZMQ_PORT=28332 \

    API_ROUTE_PREFIX="api" \
    UI_ROUTE_PREFIX="" \

    API_CACHE_ENABLE=1 \
    API_LIMIT_ENABLE=1 \
    API_LIMIT_WHITELIST="127.0.0.1 ::1" \
    API_LIMIT_BLACKLIST="" \
    API_LIMIT_COUNT=10800 \
    API_LIMIT_INTERVAL=10800000 \
    API_LIMIT_WHITELIST_COUNT=108000 \
    API_LIMIT_WHITELIST_INTERVAL=10800000 \
    API_LIMIT_BLACKLIST_COUNT=0 \
    API_LIMIT_BLACKLIST_INTERVAL=10800000

HEALTHCHECK --interval=5s --timeout=5s --retries=5 CMD curl -s "http://localhost:3001/{$API_ROUTE_PREFIX}/sync" | jq -r -e ".status==\"finished\""

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD "./dashcore-start.sh"
