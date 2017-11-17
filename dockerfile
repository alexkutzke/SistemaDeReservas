FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y npm git libfontconfig1-dev cron  build-essential libpq-dev nodejs nodejs-legacy sqlite && rm -rf /var/lib/apt/lists/*
RUN npm install -g phantomjs

ENV INSTALL_PATH /sisres
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY . ./
