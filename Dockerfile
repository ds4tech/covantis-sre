FROM golang:1.17rc1-alpine

# Add Maintainer Info
LABEL maintainer="Mateusz Szymczyk"

# Set the Current Working Directory inside the container
WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
COPY . ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download && go mod verify

RUN echo $(ls -1 /usr/src/app)

# Build the Go app
RUN go build -v -o /usr/local/bin/webserver ./cmd/main.go


# Expose port 8888 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["webserver"]
