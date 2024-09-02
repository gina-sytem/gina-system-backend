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