FROM rust:latest as builder

# Create a new directory for our app

WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Copy the source code
COPY src ./src

# Build the application
RUN cargo build --release

# Final stage
FROM debian::bullseye-slim

#Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the built executable from the builder stage
COPY --from=builder /app/target/release/backend /usr/local/bin/backend

# Expose the port your app runs on
EXPOSE 8080

# Run the binary
CMD ["backend"]