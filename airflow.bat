@echo off
SET AIRFLOW_VERSION=2.10.0
SET COMPOSE_FILE=docker-compose.yaml

:: Step 1: Download the docker-compose.yaml file
echo Downloading Apache Airflow Docker Compose file for version %AIRFLOW_VERSION%...
:: curl -LfO https://airflow.apache.org/docs/apache-airflow/%AIRFLOW_VERSION%/%COMPOSE_FILE%

 curl -LfO https://github.com/bdllhdrss3/utilities/blob/main/airflow

:: Step 2: Create necessary directories
echo Creating directories: dags, logs, plugins...
mkdir dags
mkdir logs
mkdir plugins

:: Step 3: Set up environment variables
echo Setting up environment variables...
echo AIRFLOW_UID=%USERNAME% > .env

:: Step 4: Initialize Airflow
echo Initializing Airflow services...
docker-compose up airflow-init

:: Wait for initialization to complete
echo Airflow initialization complete. Starting Airflow services...
docker-compose up -d

:: Step 5: Print completion message
echo Airflow services are up and running.
