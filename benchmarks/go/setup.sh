DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "compiling"
#docker run -e "CGO_ENABLED=0" -e "GOOS=linux" --rm -v "$PWD":/go/src/app -w /go/src/app golang:1.7 sh -c "go get -d -v && go build -a -installsuffix cgo -v -o main"
echo "building benchmark image"
docker build -t $DOCKER_IMAGE $DIR
