FROM ruby:2.5.1

# Core packages
RUN apt-get update -qq && \
  apt-get install -y -q --no-install-recommends --fix-missing \
    build-essential nodejs libpq-dev postgresql-client-9.6

ENV ROOT_APP_DIR=/webapp/current/
RUN mkdir -p $ROOT_APP_DIR
WORKDIR $ROOT_APP_DIR

COPY Gemfile $ROOT_APP_DIR
COPY Gemfile.lock $ROOT_APP_DIR

RUN bundle install

ADD . .
