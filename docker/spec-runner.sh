#!/bin/bash -e

echo "Running $@ in $(hostname)"

DB=docker_`hostname`
TEST_DB=$(rails runner "puts Rails.configuration.database_configuration['test']['database']")

echo "Creating database $DB for rspec $@ ..."

echo "CREATE DATABASE $DB WITH TEMPLATE \"$TEST_DB\" OWNER postgres;" | bundle exec rails dbconsole

echo "Running DATABASE_NAME=$DB bundle exec rspec --colour --tty $@"

DATABASE_NAME=$DB bundle exec rspec --colour --tty $@

echo "Cleaning up db ... "

echo "DROP DATABASE $DB" | bundle exec rails dbconsole

echo "Spec run complete."