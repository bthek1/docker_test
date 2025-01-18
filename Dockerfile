# Pull base image
FROM python:3.12.3-slim-bookworm

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install necessary tools
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    vim \
    python3-pip \
    python3-dev \
    build-essential \
    direnv \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set ARG for password (to be passed during build)
ARG USER_PASSWORD

# Create a non-root user with sudo privileges
RUN useradd -ms /bin/bash devuser && \
    echo "devuser:${USER_PASSWORD}" | chpasswd && \
    usermod -aG sudo devuser

# Switch to the non-root user
USER devuser

# Set the working directory
WORKDIR /home/devuser/app

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3

RUN poetry config virtualenvs.create false
# Add Poetry to PATH
ENV PATH="/home/devuser/.local/bin:$PATH"

# Enable direnv by adding configuration to .bashrc
RUN echo 'eval "$(direnv hook bash)"' >> ~/.bashrc



# Expose a default port
EXPOSE 8000

# Default command
CMD ["bash"]
