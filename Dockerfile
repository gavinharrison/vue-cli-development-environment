FROM node:lts

LABEL maintainer="docker@gavinharrison.me.uk"
LABEL version="1.0"
LABEL description="This is a docker image for a local vue cli development enviroment."

ENV DEBIAN_FRONTEND=noninteractive

RUN npm install --unsafe-perm -g @vue/cli && vue --version

COPY ./src/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

WORKDIR /project/
EXPOSE 8000 8080

ENTRYPOINT [ "/docker-entrypoint.sh" ]