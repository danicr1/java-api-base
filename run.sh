# Compiles and generates JAR package
./run-app.sh -b

# Builds the server image with new JAR
docker compose -f ./docker/docker-compose.yaml build

# Launches server and DB containers
docker compose -f ./docker/docker-compose.yaml up -d