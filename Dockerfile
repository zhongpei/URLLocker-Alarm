FROM golang:1.12 AS go-build

WORKDIR /go/src/github.com/urlooker/alarm
COPY . .
RUN go get -v
RUN go build

FROM golang:1.12 AS prod
WORKDIR /app
COPY --from=go-build  /go/src/github.com/urlooker/alarm/alarm /app/alarm
COPY --from=go-build  /go/src/github.com/urlooker/alarm/cfg.example.json /app/cfg.json
COPY --from=go-build  /go/src/github.com/urlooker/alarm/script /app/script
RUN chmod +x /app/alarm
EXPOSE 1986/tcp
CMD ["/app/alarm"]
