# Use the Debian Buster base image
FROM debian:buster
# FROM ubuntu:20.04

# Set non-interactive environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

# Set the time zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install build dependencies for Rust and PostgreSQL
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    pkg-config \
    curl \
    postgresql-server-dev-all \
    libreadline-dev \
    zlib1g-dev \
    ncdu pv git nano htop tmux

# Install Rustup and set up the Rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly

# Set the Rust environment variables
SHELL ["bash", "-c"]
ENV PATH="/root/.cargo/bin:$PATH"

# Install Rust components and targets for PostgreSQL extension development
RUN rustup component add rustfmt clippy
# RUN rustup target add x86_64-unknown-linux-gnu

# Create a non-root user
RUN useradd -ms /bin/bash pguser

# Copy .cargo and .rustup to pguser's home directory
RUN cp -r /root/.cargo /home/pguser/ && \
    cp -r /root/.rustup /home/pguser/ && \
    chown -R pguser:pguser /home/pguser/.cargo /home/pguser/.rustup

# Add cargo path to the pguser's PATH
RUN echo 'export PATH="/home/pguser/.cargo/bin:$PATH"' >> /home/pguser/.bashrc

USER pguser

# Add cargo path to the pguser's PATH
ENV PATH="/home/pguser/.cargo/bin:$PATH"

# Install cargo-pgx
RUN cargo +nightly install cargo-pgx

# Initialize pgx
RUN cargo +nightly pgx init

# Clone the pg_meritrank repository
WORKDIR /app
RUN git clone https://github.com/vsradkevich/pg_meritrank.git

# Set the working directory
WORKDIR /app/pg_meritrank

# Build the project
RUN cargo +nightly build

# Rename files to remove '.example' suffix
RUN mv sql/implement_triggers_new.sql.example sql/implement_triggers_new.sql && \
    mv sql/initial_structure.sql.example sql/initial_structure.sql && \
    mv .env.example .env

RUN sed -i 's|INITIAL_STRUCTURE_SQL=./sql/initial_structure.sql|INITIAL_STRUCTURE_SQL=/app/pg_meritrank/sql/initial_structure.sql|' .env && \
    sed -i 's|IMPLEMENT_TRIGGERS_SQL=./sql/implement_triggers_new.sql|IMPLEMENT_TRIGGERS_SQL=/app/pg_meritrank/sql/implement_triggers_new.sql|' .env

# Run the tests using cargo-pgx
RUN cargo +nightly pgx test
