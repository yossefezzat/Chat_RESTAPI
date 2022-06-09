FROM ruby:2.7.5

RUN mkdir /chatApi
WORKDIR /chatApi

COPY Gemfile Gemfile.lock ./
COPY .env ./

RUN bundle install

COPY . .
CMD rails server