# Builder stage
FROM rust:1.82.0 AS builder

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install diesel CLI in the builder stage
RUN cargo install diesel_cli --no-default-features --features postgres

# Build the project
RUN cargo build --release

# Production stage
FROM debian:bookworm

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ca-certificates \
    postgresql-client \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy diesel CLI binary from builder stage
COPY --from=builder /usr/local/cargo/bin/diesel /usr/local/bin/diesel

# Copy binary from builder stage
COPY --from=builder /app/target/release/backend /usr/local/bin/backend

# Expose port
EXPOSE 8000

# Run the binary
CMD ["backend"]