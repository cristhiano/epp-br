FROM ruby:2.2-wheezy

WORKDIR /app

COPY . .

RUN bundle install --path vendor/bundle
