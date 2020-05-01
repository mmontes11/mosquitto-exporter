FROM arm64v8/golang:1.13-alpine3.10

LABEL maintainer="Martín Montes <martin11lrx@gmail.com>"

WORKDIR /go/src/github.com/mmontes11/mosquitto_exporter

COPY . .

RUN apk --no-cache add curl git make perl

RUN make build

FROM arm64v8/alpine:3.8

LABEL maintainer="Martín Montes <martin11lrx@gmail.com>"

COPY --from=0 /go/src/github.com/mmontes11/mosquitto_exporter/bin/mosquitto_exporter /bin/mosquitto_exporter

EXPOSE 9113

ENTRYPOINT [ "/bin/mosquitto_exporter" ]
