#!/bin/bash

############################################################
# Variables                                                     #
############################################################
docker_compose_file_path="./docker/docker-compose.yaml"

############################################################
# Help                                                     #
############################################################
show_help()
{
    # Display Help
    echo "Syntax: run [option]"
    echo
    echo "options:"
    echo "--build | -b     Build the project using mvn clean install."
    echo "--start | -x     Build the project, build docker images and launch services with compose."
    echo "--stop | -s      Stop all services with compose."
    echo "--local | -l     Launch the embbeded tomcat included in Spring Boot."
    echo "--package | -p   Generate JAR."
    echo "--db | -d        Launch mysql command line client"
    echo "--help | -h      Print this help."
    echo
}

compile_and_launch_app()
{
    ./mvnw clean install
    echo
    echo "*******************************"
    echo "BUILDING DOCKER IMAGES..."
    echo "*******************************"
    echo
    docker compose -f $docker_compose_file_path build
    echo
    echo "*******************************"
    echo "LAUNCHING DOCKER COMPOSE..."
    echo "*******************************"
    echo
    docker compose -f $docker_compose_file_path up -d
}

# Process options
while :; do
    case $1 in
        -h|-\?|--help)
            show_help    # Display a usage synopsis.
            exit
            ;;
        -b|--build)
            ./mvnw clean install
            exit
            ;;
        -p|--package)
            ./mvnw clean package
            exit
            ;;
        -l|--local)
            ./mvnw spring-boot:run
            exit
            ;;
        -x|--start)
            compile_and_launch_app
            exit
            ;;
        -s|--stop)
            docker compose -f $docker_compose_file_path down
            exit
            ;;
        -d|--db)
            echo "Connecting to mysql command line client..."
            echo
            docker exec -it $docker_container_name mysql --user="$mysql_root_user" --password="$mysql_root_password"
            exit
            ;;
        -?*)
            printf 'ERROR: Unknown option: %s\n' "$1" >&2
            exit 1
            ;;
        *)               # Default case: argument without dashes.
            echo "ERROR: This script doesn't take any arguments, only options." >&2
            exit 1
    esac    

    #shift                # Process next argument
done
