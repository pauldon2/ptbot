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
REGISTRY=pauldon/

format: 
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP}.bin -ldflags "-X="github.com/pauldon2/ptbot/cmd.appVersion=${VERSION}

image: format get build
	docker buildx build --platform ${TARGETOS}/${TARGETARCH} . -t ${REGISTRY}${APP}:${VERSION}-${TARGETOS}

push:
	docker push ${REGISTRY}${APP}:${VERSION}-${TARGETOS}
	
clean: 
	rm -rf ${APP}.bin
	docker rmi ${REGISTRY}${APP}:${VERSION}-${TARGETOS}
