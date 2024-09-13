# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: confirm
confirm:
	@echo -n 'Are you sure? [y/N] ' && read ans && [ $${ans:-N} = y ]

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## db/migration/up: apply all up database migration
.PHONY: db/migration/up
db/migration/up: confirm
	@echo 'Running up migrations...'
	@mvn flyway:migrate \
 	-Dflyway.user=${GINA_SYSTEM_DATABASE_USERNAME} \
 	-Dflyway.password=${GINA_SYSTEM_DATABASE_PASSWORD} \
 	-Dflyway.url=${GINA_SYSTEM_DATABASE_URL}
 	-Dflyway.locations=classpath:db/migration/structure, classpath:db/migration/data

## db/migration/info: Prints the details and status information about all the migrations
.PHONY: db/migration/info
db/migration/info:
	@mvn flyway:info \
	-Dflyway.user=${GINA_SYSTEM_DATABASE_USERNAME} \
	-Dflyway.password=${GINA_SYSTEM_DATABASE_PASSWORD} \
	-Dflyway.url=${GINA_SYSTEM_DATABASE_URL}

## db/migration/new_file: Creates a new migration file
.PHONY: db/migration/new_file
db/migration/new_file:
	@bash ./create_migration.sh

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## tests: Run tests
.PHONY: tests
tests:
	@echo 'Running tests...'
	@mvn -B clean test --file pom.xml


# ==================================================================================== #
# BUILD
# ==================================================================================== #

## build/jvm: Build the project to be run on a JVM environment
.PHONY: build/jvm
build/jvm:
	@echo 'Building for JVM...'
	@mvn -B -Dmaven.test.skip clean package

## build/graalvm: Build an executable to be run without JVM
.PHONY: build/graalvm
build/graalvm:
	@echo 'Building for GraalVM...'
	@mvn -Pnative -Dmaven.test.skip spring-boot:build-image

## /build/docker/jvm: Build a Docker image with jvm
.PHONY: /build/docker/jvm
build/docker/jvm:
	@echo 'Building docker image for JVM...'
	@docker build --tag 'gina-system-backend' -f Dockerfile_jdk .

.PHONY: temp/up
temp/up:
	@docker run --rm -p 8080:8080 --network dev_local \
	-e GINA_SYSTEM_DATABASE_URL='jdbc:postgresql://postgres_gina_system:5431/gina_system' \
    -e GINA_SYSTEM_DATABASE_USERNAME='adminadmin' \
    -e GINA_SYSTEM_DATABASE_PASSWORD='adminadmin' \
    -e GINA_SYSTEM_SERVER_PORT='8089'