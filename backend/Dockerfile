
# Builder stage
FROM rust:1.82.0 AS builder

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies and build
RUN cargo build --release

# Production stage
FROM debian:bookworm

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy binary from builder stage
COPY --from=builder /app/target/release/backend /usr/local/bin/backend

# Expose port
EXPOSE 8000

# Run the binary
CMD ["backend"]
