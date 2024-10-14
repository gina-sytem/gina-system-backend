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

# Native Builds

## build/jvm: Build the project to be run on a JVM environment
.PHONY: build/jvm
build/jvm:
	@echo '### Make sure Java JDK is installed, version 21 minimum ### '
	@echo 'Building for JVM...'
	@mvn -B -Dmaven.test.skip clean package

## build/graalvm: Build an executable to be run without JVM
.PHONY: build/graalvm
build/graalvm:
	@echo '### Make sure GraalVM JDK is installed, version 21 minimum ###'
	@echo 'Building for GraalVM...'
	@mvn clean native:compile -B -Pnative -Dmaven.test.skip

# Docker Builds

## build/docker/jvm: Build a Docker image with jvm
.PHONY: build/docker/jvm
build/docker/jvm:
	@echo '### Make sure Docker is installed ###'
	@echo 'Building docker image for JVM...'
	@docker build --tag 'gina-system-backend-jvm' -f Dockerfile_jvm .

## build/docker/jvm/debug: Build a Docker image with jvm with more logs
.PHONY: build/docker/jvm/debug
build/docker/jvm/debug:
	@echo '### Make sure Docker is installed ###'
	@echo 'Building docker image for JVM with more logs for debugging'
	@docker build --tag 'gina-system-backend-jvm' -f Dockerfile_jvm . --progress=plain --no-cache

## build/docker/graalvm: Build a Docker image with GraalVM
.PHONY: bjdkuild/docker/graalvm
build/docker/graalvm:
	@echo '### Make sure Docker is installed ###'
	@echo 'Building docker image for GraalVM...'
	@docker build --tag 'gina-system-backend-graalvm' -f Dockerfile_graalvm .

## build/docker/graalvm: Build a Docker image with GraalVM with more logs
.PHONY: build/docker/graalvm/debug
build/docker/graalvm/debug:
	@echo '### Make sure Docker is installed ###'
	@echo 'Building docker image for GraalVM with more logs for debugging'
	@docker build --tag 'gina-system-backend-graalvm' -f Dockerfile_graalvm . --progress=plain --no-cache
