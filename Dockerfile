FROM golang:1.13

LABEL maintainer="Martín Montes <martin11lrx@gmail.com>"

ENV WORKDIR /go/src/github.com/mmontes11/mosquitto-exporter
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}
COPY . ${WORKDIR}

RUN make build

EXPOSE 9113

ENTRYPOINT [ "bin/mosquitto-exporter" ]
