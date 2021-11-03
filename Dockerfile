# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:2.7

# Install production dependencies.
WORKDIR /usr/src/app
COPY Gemfile ./
# ENV BUNDLE_FROZEN=true
ENV RAILS_SERVE_STATIC_FILES=true
RUN gem install bundler && bundle install

# Copy local code to the container image.
COPY . ./

RUN ruby ./bin/rails db:migrate
# Run the web service on container startup.
CMD ["ruby", "./bin/rails", "server", "-e", "production", "-b", "0.0.0.0"]