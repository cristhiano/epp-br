FROM ruby:2.2-wheezy

WORKDIR /app

COPY . /app

RUN bundle install

VOLUME /app
