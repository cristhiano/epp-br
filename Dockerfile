FROM ruby:2.2.2-wheezy

WORKDIR /epp-br

COPY . .

RUN bundle install --jobs 4

CMD ["guard"]
