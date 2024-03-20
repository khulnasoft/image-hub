FROM golang:1.13.5 as bd
WORKDIR /github.com/khulnasoft/dockercon-2020-api
ADD . .
RUN GOPROXY=direct GOSUMDB=off go build -a -o /api .
CMD ["/api"]