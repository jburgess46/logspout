FROM gliderlabs/alpine:3.4

RUN apk add ca-certificates \
COPY certificates/* /usr/local/share/ca-certificates/
RUN update-ca-certificates

ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 80

COPY . /src
RUN cd /src && ./build.sh "$(cat VERSION)"

ONBUILD COPY ./build.sh /src/build.sh
ONBUILD COPY ./modules.go /src/modules.go
ONBUILD RUN cd /src && ./build.sh "$(cat VERSION)-custom"
