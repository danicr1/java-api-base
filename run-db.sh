#!/bin/bash

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
    echo "--local | -l     Launch the embbeded tomcat included in Spring Boot."
    echo "--package | -p   Generate JAR."
    echo "--help | -h      Print this help."
    echo
}

create_mysql_container()
{
    docker network create $docker_network_name
    docker run --name $docker_container_name -e MYSQL_ROOT_PASSWORD=$mysql_root_password -d mysql:$mysql_docker_tag
}

remove_mysql_container()
{
    docker stop $docker_container_name
    docker network rm $docker_network_name
    docker rm $docker_container_name
}

docker_network_name="db-network"
docker_container_name="db-mysql"

mysql_docker_tag="8.2.0"

mysql_root_password="testpass"

# Process options
while :; do
    case $1 in
        -h|-\?|--help)
            show_help    # Display a usage synopsis.
            exit
            ;;
        -c|--create)
            create_mysql_container
            exit
            ;;
        -r|--remove)
            remove_mysql_container
            exit
            ;;
        -c|--clean)
            remove_mysql_container
            create_mysql_container
            exit
            ;;
        -s|--start)
            docker start $docker_container_name
            exit
            ;;
        -t|--stop)
            docker stop $docker_container_name
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
