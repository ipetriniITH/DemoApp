FROM ruby:2.7.1-alpine3.11

RUN apk update \
    && apk upgrade \
    && apk add build-base \
               libffi-dev \
               libxml2-dev \
               libxslt-dev \
               mariadb-dev \
               mysql \
               mysql-client \
               ruby-dev \
               build-base \
               tzdata \
               git

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.1.4
RUN bundle install

# Never run as root
RUN addgroup -g 1000 -S app \
    && adduser -u 1000 -S app -G app
USER app

COPY --chown=app:app . /myapp

EXPOSE 3000

# Start app.
ENTRYPOINT ["./entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
