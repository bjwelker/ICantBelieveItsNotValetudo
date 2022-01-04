FROM node:lts-slim

WORKDIR /app


# Build tools for armhf and arm64 to build canvas
RUN ARCH=$(dpkg --print-architecture) \ 
    && if [ "$ARCH" = "armhf" ] || [ "$ARCH" = "arm64" ]; then \
    apt-get update && apt-get install -y \
    build-essential \ 
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    wget \
    unzip \
    nano \
    && rm -rf /var/lib/apt/lists/* \
    ;  fi

RUN wget https://github.com/bjwelker/ICantBelieveItsNotValetudo/archive/refs/heads/master.zip
RUN unzip master.zip
RUN mv ICantBelieveItsNotValetudo-master/* .
RUN rm master.zip
RUN rm -r ICantBelieveItsNotValetudo-master
RUN npm install
COPY . /app

CMD ["npm", "start"]
