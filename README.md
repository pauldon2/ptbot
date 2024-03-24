# ptbot

Simple telegram bot

# Name
t.me/paulshevtsov_bot

# Install & build
git clone -b opentelemetry https://github.com/pauldon2/ptbot.git
cd ptbot
go get
go build -ldflags "-X="github.com/pauldon2/ptbot/cmd.appVersion=v1.0.2

# run
export TELE_TOKEN
./ptbot start

