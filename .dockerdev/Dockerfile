# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:${RUBY_VERSION}-slim

# Rails app lives here
ENV APP_HOME=/rails
WORKDIR ${APP_HOME}
RUN useradd -ms /bin/false app_user

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips sqlite3

ENV RAILS_ENV="development" \
    GEM_HOME="/bundle" \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH=${GEM_HOME}
ENV BUNDLE_APP_CONFIG=${BUNDLE_PATH} \
    BUNDLE_BIN=${BUNDLE_PATH}/bin
ENV PATH=${APP_HOME}/bin:${BUNDLE_BIN}:$PATH

COPY Gemfile Gemfile.lock ./

ENV BUNDLER_VERSION=2.6.9
RUN gem update --system && \
    gem install bundler -v ${BUNDLER_VERSION} && \
    gem install foreman && \
    chown -R app_user:app_user .
