FROM ruby:2.7.5-slim AS base

ARG BUNDLE_WITHOUT="test:development"
ENV BUNDLE_WITHOUT="${BUNDLE_WITHOUT}"

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  nodejs && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN BUNDLER_VERSION=$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -1 | tr -d ' ') && \
  gem install bundler -v "$BUNDLER_VERSION"

RUN bundle install

COPY . .

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]

FROM base AS build

ARG BUNDLE_WITHOUT="test:development"
ENV BUNDLE_WITHOUT="${BUNDLE_WITHOUT}"

RUN ./configure.sh r46 && bundle exec middleman build && mv build /opt/rees46
RUN ./configure.sh kameleoon && bundle exec middleman build && mv build /opt/kameleoon
RUN ./configure.sh pc && bundle exec middleman build && mv build /opt/personaclick

FROM nginx:1 AS prod

ENV CLIENT=rees46

COPY --from=build /opt /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/templates/default.conf.template
