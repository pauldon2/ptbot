FROM alpine:3.19.1


WORKDIR /
COPY ./ptbot .
ENTRYPOINT ["./ptbot.bin"]


