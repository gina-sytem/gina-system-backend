#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: create_migration.sh
# Description: This script automates the creation of SQL migration files.
#              It determines the correct version number for the migration based
#              on existing files in the migration directory and creates a new
#              file with the provided description.
#
# Usage:       ./create_migration.sh [DESCRIPTION]
#
# Parameters:
#   DESCRIPTION (optional): A short description of the migration.
#                           If not provided, the script will prompt the user to
#                           enter it.
#
#              The DESCRIPTION must only contain letters, numbers, and underscores.
#              No spaces are allowed. Underscores should be used as word separators.
#
# File Name Format:
#   The migration file will be created with the following format:
#   V<Version Number>__<Description>.sql
#
#   - <Version Number>: Automatically determined based on existing migration files.
#   - <Description>: The provided or entered description, using underscores (_) as word separators.
#
# Compatibility:
#   The generated migration files are fully compatible with Flyway, a popular
#   database migration tool. Flyway uses these files to apply schema changes
#   incrementally, ensuring that the database stays in sync with your application code.
#
# The script performs the following steps:
#   1. Navigates to the directory where the script is located.
#   2. Changes to the migration directory relative to the script location.
#   3. Confirms that the directory is correct with the user.
#   4. Prompts for a valid migration description if not provided.
#   5. Determines the next migration version number based on existing files.
#   6. Creates a new migration file with the format V<Version>__<Description>.sql.
#
# Example:
#   ./create_migration.sh "add_new_table"
#   This will create a file like V2__add_new_table.sql if V1__initial_migration.sql exists.
# -----------------------------------------------------------------------------

# Function to get the script directory in a portable way
get_script_dir() {
  # Use realpath if available, otherwise fallback
  if command -v realpath > /dev/null 2>&1; then
    dirname "$(realpath "$0")"
  else
    # Fallback for MacOS (zsh)
    cd "$(dirname "$0")" || exit
    pwd
  fi
}

# Get the directory where the script is located
SCRIPT_DIR=$(get_script_dir)

# Define the migration path relative to the script directory
MIGRATION_PATH="$SCRIPT_DIR/src/main/resources/migration/data"

# Navigate to the migration path
if [ -d "$MIGRATION_PATH" ]; then
  cd "$MIGRATION_PATH" || { echo "Failed to change directory to $MIGRATION_PATH"; exit 1; }
else
  echo "The migration path $MIGRATION_PATH does not exist."
  exit 1
fi

# Ask if the current directory is the migration path
read -p "Is this the correct migration path: $MIGRATION_PATH? (y/n): " RESPONSE

# If the user says no, ask for the correct path and change to that directory
if [[ "$RESPONSE" != "y" ]]; then
  read -p "Please enter the correct migration path: " CUSTOM_MIGRATION_PATH
  if [ -d "$CUSTOM_MIGRATION_PATH" ]; then
    cd "$CUSTOM_MIGRATION_PATH" || { echo "Failed to change directory to $CUSTOM_MIGRATION_PATH"; exit 1; }
  else
    echo "The provided path does not exist."
    exit 1
  fi
fi

# Function to validate the description
validate_description() {
  if [[ "$1" =~ \  ]]; then
    echo "Description cannot contain spaces. Use underscores (_) as word separators."
    return 1
  elif [[ ! "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Description can only contain letters, numbers, and underscores."
    return 1
  else
    return 0
  fi
}

# Check if description parameter is provided
if [ -z "$1" ]; then
  read -p "Please enter the description for the migration (only letters, numbers, and underscores are allowed): " DESCRIPTION
else
  DESCRIPTION=$1
fi

# Ensure that the description is valid
while ! validate_description "$DESCRIPTION"; do
  read -p "Please enter a valid description for the migration (only letters, numbers, and underscores are allowed): " DESCRIPTION
done

# Find the highest version number in the current directory
HIGHEST_VERSION=$(ls V*__*.sql 2>/dev/null | sed -E 's/^V([0-9]+)__.*$/\1/' | sort -n | tail -1)

# If no version found, start with 1
if [ -z "$HIGHEST_VERSION" ]; then
  VERSION=1
else
  VERSION=$((HIGHEST_VERSION + 1))
fi

# Create the file name
FILENAME="V${VERSION}__${DESCRIPTION}.sql"

# Create the file
touch "$FILENAME"

# Inform the user
echo "Created migration file: $FILENAME"