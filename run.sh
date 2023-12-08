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
