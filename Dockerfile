# syntax=docker/dockerfile:1

FROM golang:1.23-alpine AS builder
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/turnkey ./cmd/turnkey

FROM scratch AS export
COPY --from=builder /out/turnkey /turnkey
