FROM golang:1.10-alpine as builder

WORKDIR /go/src/github.com/jobteaser/csp-handler
COPY . /go/src/github.com/jobteaser/csp-handler/

RUN apk --no-cache add git
RUN go get
RUN CGO_ENABLED=1 GOOS=linux go build -o csp-handler

FROM alpine:3.7

LABEL vendor="Jobteaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-date="2018-04-30" \
      maintainer="dev@jobteaser.com"

COPY --from=builder /go/src/github.com/jobteaser/csp-handler/csp-handler /csp-handler
COPY --from=builder /go/src/github.com/jobteaser/csp-handler/LICENSE /LICENSE
