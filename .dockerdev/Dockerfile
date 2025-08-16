# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:${RUBY_VERSION}

# Rails app lives here
ENV APP_HOME=/rails
WORKDIR $APP_HOME
RUN useradd -ms /bin/false app_user

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3 libc6-dev build-essential libyaml-dev

ENV RAILS_ENV="development"
ENV PATH=$APP_HOME/bin:$PATH

COPY Gemfile Gemfile.lock ./

ARG BUNDLER_VERSION=2.6.9
RUN gem update --system && \
    gem install bundler -v ${BUNDLER_VERSION} && \
    gem install bundler-audit && \
    gem install foreman && \
    chown -R app_user:app_user .
