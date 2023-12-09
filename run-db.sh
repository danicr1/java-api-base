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
    echo "--create | -c    Creates a new mysql container and network."
    echo "--remove | -r    Removes the exisitng mysql container and network."
    echo "--clean | -c     Remove existing containers and networks and create new ones."
    echo "--start| -s      Launch a previously stopped container."
    echo "--stop | -t      Stop a running mysql container."
    echo "--client | -x    Connect to a running mysql instance using command line client."
    echo "--help | -h      Print this help."
    echo
}

create_mysql_container()
{
    echo "Creating mysql network and container..."
    docker network create $docker_network_name
    docker run --name $docker_container_name --network $docker_network_name -e MYSQL_ROOT_PASSWORD="$mysql_root_password" -d $mysql_docker_image:$mysql_docker_tag
}

remove_mysql_container()
{
    echo "Removing mysql network and container..."
    docker stop $docker_container_name
    docker network rm $docker_network_name
    docker rm $docker_container_name
}

docker_network_name="db-network"
docker_container_name="db-mysql"

mysql_docker_image="mysql"
mysql_docker_tag="8.2.0"

mysql_root_user="root"
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
        -x|--client)
            echo "Launching mysql command line client..."
            docker run -it --network $docker_network_name --rm $mysql_docker_image:$mysql_docker_tag mysql --host="$docker_container_name" --user="$mysql_root_user" --password="$mysql_root_password"
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
