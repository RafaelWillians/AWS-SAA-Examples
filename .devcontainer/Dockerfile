# Use the official image as a parent image
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Set working directory
WORKDIR /workspace

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl unzip sudo

# Download, unzip, and install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install

# Download and install Microsoft Powershell
RUN curl "https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb" -o "packages-microsoft-prod.deb" && \
    sudo dpkg -i packages-microsoft-prod.deb && \
    sudo apt-get update && \
    sudo apt-get install -y powershell

# Set the working directory back
WORKDIR $THEIA_WORKSPACE_ROOT

# Clean up
RUN rm -rf /workspace/awscliv2.zip /workspace/aws
RUN rm -rf /workspace/packages-microsoft-prod.deb

