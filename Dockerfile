FROM golang:1.20.6-bullseye AS builder
LABEL AUTHOR="Seungkyu Ahn" EMAIL="seungkyua@gmail.com"

RUN mkdir -p /build
WORKDIR /build

COPY . .
#RUN go mod tidy && go mod vendor
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/helloworld-docker .

RUN mkdir -p /dist
WORKDIR /dist
RUN cp /build/bin/helloworld-docker ./helloworld-docker



FROM golang:1.20.6-alpine3.18

RUN mkdir -p /app
WORKDIR /app

COPY --chown=0:0 --from=builder /dist /app/
EXPOSE 8080

ENTRYPOINT ["/app/helloworld-docker"]
