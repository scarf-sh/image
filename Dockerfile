FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y

# INSTALL GOLANG
RUN wget -c https://golang.org/dl/go1.16.4.linux-amd64.tar.gz -O - \
    | sudo tar -xz -C /usr/local

# SETUP GOLANG
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV PATH=$GOROOT/bin:$GOPATH/go:$PATH

# INSTALL THE 3 LIBS NEEDED FROM THE README
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y libassuan-dev libgpgme-dev libostree-dev

# GO INSTALL GOLANGCI-LINT
RUN apt-get install -y curl
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
    | sh -s -- -b $(go env GOPATH)/bin v1.40.1

# INSTALL OTHER MISSING TOOLS & LIBS
RUN apt-get install -y git make libbtrfs-dev libdevmapper-dev

# COPY THE PROJECT SOURCE IN
ADD ./ /src/
WORKDIR /src
