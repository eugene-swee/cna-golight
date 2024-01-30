# Stage 1: Build the Go application
FROM golang:1.17 AS builder

WORKDIR /app

COPY . .

# This value enables the Go module system if a go.mod file is present in the project directory. If no go.mod file is found, the legacy GOPATH mode is used
ENV GO111MODULE='auto'

# Build the Go application
RUN go build -o myapp

# Stage 2: Create a lightweight runtime image
FROM alpine:3.19.1

WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/myapp .

# Define the command to run the application
CMD ["./myapp"]
