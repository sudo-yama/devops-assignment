FROM golang:1.21.4-alpine

# Add user
RUN adduser -u 82 -S -G www-data www-data || true

WORKDIR /app

# Copy go.mod and download dependencies
COPY go.mod . 
RUN go mod download

# Copy source code and build
COPY *.go . 
RUN CGO_ENABLED=0 GOOS=linux go build -o hello-api

# Change permission
RUN chown -R www-data:www-data /app

# Change user www-data
USER www-data

# Expose port
EXPOSE 8080

# Run the application
CMD ["/app/hello-api"]
