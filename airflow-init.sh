#!/bin/bash

# Function to install Docker
install_docker() {
  echo "Docker is not installed. Installing Docker..."
  # Update the apt package index and install required dependencies
  sudo apt-get update
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

  # Add Docker's official GPG key and set up the stable repository
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  # Install Docker Engine
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y

  # Start and enable Docker
  sudo systemctl start docker
  sudo systemctl enable docker

  # Verify installation
  sudo docker --version
}

# Function to install Docker Compose
install_docker_compose() {
  echo "Docker Compose is not installed. Installing Docker Compose..."
  # Get the latest version of Docker Compose
  COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
  sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

  # Set executable permission
  sudo chmod +x /usr/local/bin/docker-compose

  # Verify installation
  docker-compose --version
}

# Step 1: Check if Docker is installed, if not install it
if ! command -v docker &> /dev/null
then
  install_docker
else
  echo "Docker is already installed."
fi

# Step 2: Check if Docker Compose is installed, if not install it
if ! command -v docker-compose &> /dev/null
then
  install_docker_compose
else
  echo "Docker Compose is already installed."
fi

# Step 3: Download the docker-compose.yaml file
AIRFLOW_VERSION="2.10.0"
COMPOSE_FILE="docker-compose.yaml"
echo "Downloading Apache Airflow Docker Compose file for version $AIRFLOW_VERSION..."
curl -LfO https://github.com/bdllhdrss3/utilities/blob/main/airflow

# Step 4: Create necessary directories
echo "Creating directories: dags, logs, plugins..."
mkdir -p ./dags ./logs ./plugins

# Step 5: Set up environment variables
echo "Setting up environment variables..."
echo -e "AIRFLOW_UID=$(id -u)" > .env

# Step 6: Initialize Airflow
echo "Initializing Airflow services..."
docker-compose up airflow-init

# Wait for initialization to complete
echo "Airflow initialization complete. Starting Airflow services..."
docker-compose up -d

# Step 7: Print completion message
echo "Airflow services are up and running."

