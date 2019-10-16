FROM ruby:2.4.6-alpine3.9 as base

# Install native dependencies
RUN apk --update --upgrade add \
    curl \
    curl-dev \
    icu-dev \
    imagemagick6-dev \
    nodejs \
    postgresql-dev \
    pcre \
    tzdata

FROM base as build
RUN apk add --virtual .builds-deps \
      build-base \
      linux-headers \
      git
COPY Gemfile ./
RUN bundle install --retry=3 --jobs=4 --without development test