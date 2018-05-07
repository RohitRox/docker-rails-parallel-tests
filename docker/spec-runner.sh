#!/bin/bash -e

echo "Running $@ in $(hostname)"

DB=docker_`hostname`
USER=`whoami`
TEST_DB=$(rails runner "puts Rails.configuration.database_configuration['test']['database']")

echo "CREATE DATABASE $DB WITH TEMPLATE \"$TEST_DB\" OWNER postgres;"

echo "CREATE DATABASE $DB WITH TEMPLATE \"$TEST_DB\" OWNER postgres;" | bundle exec rails dbconsole

DATABASE_NAME=$DB bundle exec rspec --colour --tty $@



