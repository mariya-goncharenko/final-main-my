FROM golang:1.23.2 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /final-main

FROM alpine:latest

COPY --from=builder /final-main /final-main

COPY tracker.db .

ENTRYPOINT ["/final-main"]
