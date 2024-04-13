FROM alpine:3.19.1

WORKDIR /

COPY ptbot .
#COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./ptbot", "start"]