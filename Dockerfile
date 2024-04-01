FROM quay.io/projectquay/golang:1.20


WORKDIR /
COPY ./ptbot .
ENTRYPOINT ["./ptbot"]


