FROM golang:1.16 as builder
ADD . /go/src/github.com/cueblox/handler
WORKDIR /go/src/github.com/cueblox/handler
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o handler ./cmd/handler 

FROM alpine:latest as alpine
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=builder /go/src/github.com/cueblox/handler/handler .
RUN mkdir /app
WORKDIR /app
ENTRYPOINT ["/usr/bin/handler"]
CMD ["/usr/bin/handler"]