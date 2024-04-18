#
APP=ptbot
#posible OS: linux,darwin,windows
TARGETOS=linux
#posible ARCH: amd64,arm,386
TARGETARCH=amd64 
#
VERSION=v1.0.3
#
#REGISTRY=gcr.io/gke-test-416709/
#REGISTRY=pauldon/
REGISTRY=ghcr.io/pauldon2/

format: 
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP} -ldflags "-X="github.com/pauldon2/ptbot/cmd.appVersion=${VERSION}

image: format get build
	docker buildx build --platform ${TARGETOS}/${TARGETARCH} . -t ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
	
clean: 
	rm -rf ${APP}
	docker rmi ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
