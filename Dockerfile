# Build the image from a ruby/alpine official image.
FROM ruby:2.7.1-alpine3.11 AS Builder

# Add arguments.
ARG myapp=/myapp

# Install dependencies so that gems will bundle properly.
RUN apk update && \
    apk upgrade && \
    apk add build-base \
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

# Set Builder's working directory.
RUN mkdir myapp
WORKDIR myapp

# Install/Update Bundler.
RUN gem install bundler -v 2.1.4

# Install gems.
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Build final image from a ruby/alpine official image.
FROM ruby:2.7.1-alpine3.11

# Install packages.
RUN apk update --no-cache &&\
    apk upgrade --no-cache &&\
    apk add --no-cache mariadb-dev \
                       tzdata \
    && rm -rf /var/cache/apk/

# Never run as root.
RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S myapp_user -G app
USER myapp_user

# Copy gems from the Builder image.
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=myapp_user:app myapp myapp

# Set the final image working directory.
WORKDIR myapp

# Start app.
ENTRYPOINT ["./entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
